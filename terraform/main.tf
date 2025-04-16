# VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = slice(data.aws_availability_zones.availability_zones.names, 0, 2)
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway     = var.vpc_enable_nat_gateway
  single_nat_gateway     = var.vpc_single_nat_gateway
  enable_dns_hostnames   = var.vpc_enable_dns_hostnames
  enable_dns_support     = var.vpc_enable_dns_support
  map_public_ip_on_launch = var.vpc_map_public_ip_on_launch
}

resource "aws_ecs_cluster" "ecs_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_iam_role" "iam_role" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "policy_attachment_task_execution" {
  role       = aws_iam_role.iam_role.name
  policy_arn = var.task_execution_policy_arn
}

resource "aws_ecs_task_definition" "task_definition_simple_time_service" {
  family                   = var.simple_time_service_family
  requires_compatibilities = var.simple_time_service_requires_compatibilities
  cpu                      = var.simple_time_service_cpu
  memory                   = var.simple_time_service_memory
  network_mode             = var.simple_time_service_network_mode
  execution_role_arn       = aws_iam_role.iam_role.arn
  container_definitions    = jsonencode([
    {
      name  = "simple-time-service"
      image = "justnotmirr/simple-time-service"
      portMappings = [{
          containerPort = 3000,
          protocol      = "tcp"
      }],
      essential = true
    }
  ])
}

resource "aws_security_group" "security_group_allow_http" {
  name = var.security_group_allow_http_name
  vpc_id = module.vpc.vpc_id
  egress {
    from_port = var.security_group_allow_http_from_port
    to_port = var.security_group_allow_http_to_port
    protocol = var.security_group_allow_http_protocol
    cidr_blocks = var.security_group_allow_http_cidr_blocks
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress_rule_80" {
  description = var.ingress_rule_80_description
  ip_protocol = var.ingress_rule_80_ip_protocol
  from_port = var.ingress_rule_80_from_port
  to_port = var.ingress_rule_80_to_port
  cidr_ipv4 = var.ingress_rule_80_cidr_ipv4
  security_group_id = aws_security_group.security_group_allow_http.id
}

resource "aws_lb" "lb_application" {
  name = var.lb_application_name
  internal = var.lb_application_internal
  load_balancer_type = var.lb_application_lb_type
  security_groups = [aws_security_group.security_group_allow_http.id]
  subnets = module.vpc.public_subnets
}

resource "aws_lb_target_group" "target_group" {
  name = var.target_group_name
  port = var.target_group_port
  protocol = var.target_group_protocol
  vpc_id = module.vpc.vpc_id

  health_check {
    path = var.target_group_hc_path
    interval = var.target_group_hc_interval
    timeout = var.target_group_hc_timeout
    healthy_threshold = var.target_group_hc_healthy_threshold
    unhealthy_threshold = var.target_group_hc_unhealthy_threshold
  }
  target_type = var.target_group_target_type
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb_application.arn
  port = var.lb_listener_port
  protocol = var.lb_listener_protocol
  default_action {
    type = var.lb_listener_default_action_type
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_security_group" "security_group_ecs_service" {
  name = var.security_group_ecs_service_name
  vpc_id = module.vpc.vpc_id
  egress {
    from_port = var.security_group_ecs_service_from_port
    to_port = var.security_group_ecs_service_to_port
    protocol = var.security_group_ecs_service_protocol
    cidr_blocks = var.security_group_ecs_service_cidr_blocks
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress_rule_application_lb" {
  description = var.ingress_rule_3000_description
  ip_protocol = var.ingress_rule_3000_ip_protocol
  from_port = var.ingress_rule_3000_from_port
  to_port = var.ingress_rule_3000_to_port
  security_group_id = aws_security_group.security_group_ecs_service.id
  referenced_security_group_id = aws_security_group.security_group_allow_http.id
}

resource "aws_ecs_service" "ecs_service_simple_time_service" {
  name = var.ecs_service_sts_name
  cluster = aws_ecs_cluster.ecs_cluster.id
  task_definition = aws_ecs_task_definition.task_definition_simple_time_service.arn
  launch_type = var.ecs_service_sts_launch_type
  desired_count = var.ecs_service_sts_desired_count

  network_configuration {
    subnets = module.vpc.private_subnets
    security_groups = [aws_security_group.security_group_ecs_service.id]
    assign_public_ip = var.ecs_service_sts_nc_assign_public_ip
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.target_group.arn
    container_name = var.ecs_service_sts_lb_container_name
    container_port = var.ecs_service_sts_lb_container_port
  }

  depends_on = [ aws_lb_listener.lb_listener ]
}