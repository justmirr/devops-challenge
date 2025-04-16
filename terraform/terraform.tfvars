# VPC variables
vpc_name = "host-vpc"
vpc_cidr = "10.0.0.0/16"
vpc_private_subnets = ["10.0.128.0/20", "10.0.144.0/20"]
vpc_public_subnets = ["10.0.0.0/20", "10.0.16.0/20"]
vpc_enable_nat_gateway = true
vpc_single_nat_gateway = true
vpc_enable_dns_hostnames = true
vpc_enable_dns_support = true
vpc_map_public_ip_on_launch = true

#ECS variables
ecs_cluster_name = "ecs-cluster-host"

task_execution_policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"

simple_time_service_family = "simple-time-service-task"
simple_time_service_requires_compatibilities = ["FARGATE"]
simple_time_service_cpu = 256
simple_time_service_memory = 512
simple_time_service_network_mode = "awsvpc"

#ALB variables
security_group_allow_http_name = "allow-http"
security_group_allow_http_from_port = 0
security_group_allow_http_to_port = 0
security_group_allow_http_protocol = "-1"
security_group_allow_http_cidr_blocks = ["0.0.0.0/0"]

ingress_rule_80_description = "http"
ingress_rule_80_ip_protocol = "tcp"
ingress_rule_80_from_port = 80
ingress_rule_80_to_port = 80
ingress_rule_80_cidr_ipv4 = "0.0.0.0/0"

lb_application_name = "host-application-lb"
lb_application_internal = false
lb_application_lb_type = "application"

target_group_name = "host-target-group"
target_group_port = 3000
target_group_protocol = "HTTP"
target_group_hc_path = "/"
target_group_hc_interval = 30
target_group_hc_timeout = 5
target_group_hc_healthy_threshold = 2
target_group_hc_unhealthy_threshold = 2
target_group_target_type = "ip"

lb_listener_port = 80
lb_listener_protocol = "HTTP"
lb_listener_default_action_type = "forward"

security_group_ecs_service_name = "ecs-service"
security_group_ecs_service_from_port = 0
security_group_ecs_service_to_port = 0
security_group_ecs_service_protocol = "-1"
security_group_ecs_service_cidr_blocks = ["0.0.0.0/0"]

ingress_rule_3000_description = "allow-from-application-lb"
ingress_rule_3000_ip_protocol = "tcp"
ingress_rule_3000_from_port = 3000
ingress_rule_3000_to_port = 3000

ecs_service_sts_name = "simple-time-service"
ecs_service_sts_launch_type = "FARGATE"
ecs_service_sts_desired_count = 1
ecs_service_sts_nc_assign_public_ip = false
ecs_service_sts_lb_container_name = "simple-time-service"
ecs_service_sts_lb_container_port = 3000