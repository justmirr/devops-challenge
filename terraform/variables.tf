# VPC variables
variable "vpc_name" {
  type = string
}
variable "vpc_cidr" {
  type = string
}
variable "vpc_private_subnets" {
  type = list(string)
}
variable "vpc_public_subnets" {
  type = list(string)
}
variable "vpc_enable_nat_gateway" {
  type = bool
}
variable "vpc_single_nat_gateway" {
  type = bool
}
variable "vpc_enable_dns_hostnames" {
  type = bool
}
variable "vpc_enable_dns_support" {
  type = bool
}
variable "vpc_map_public_ip_on_launch" {
  type = bool
}

#ECS
variable "ecs_cluster_name" {
  type = string
}
variable "task_execution_policy_arn" {
  type = string
}
variable "simple_time_service_family" {
  type = string
}
variable "simple_time_service_requires_compatibilities" {
  type = list(string)
}
variable "simple_time_service_cpu" {
  type = number
}
variable "simple_time_service_memory" {
  type = number
}
variable "simple_time_service_network_mode" {
  type = string
}

#ALB
variable "security_group_allow_http_name" {
  type = string
}
variable "security_group_allow_http_from_port" {
  type = number
}
variable "security_group_allow_http_to_port" {
  type = number
}
variable "security_group_allow_http_protocol" {
  type = string
}
variable "security_group_allow_http_cidr_blocks" {
  type = list(string)
}
variable "ingress_rule_80_description" {
  type = string
}
variable "ingress_rule_80_ip_protocol" {
  type = string
}
variable "ingress_rule_80_from_port" {
  type = number
}
variable "ingress_rule_80_to_port" {
  type = number
}
variable "ingress_rule_80_cidr_ipv4" {
  type = string
}
variable "lb_application_name" {
  type = string
}
variable "lb_application_internal" {
  type = bool
}
variable "lb_application_lb_type" {
  type = string
}
variable "target_group_name" {
  type = string
}
variable "target_group_port" {
  type = number
}
variable "target_group_protocol" {
  type = string
}
variable "target_group_hc_path" {
  type = string
}
variable "target_group_hc_interval" {
  type = number
}
variable "target_group_hc_timeout" {
  type = number
}
variable "target_group_hc_healthy_threshold" {
  type = number
}
variable "target_group_hc_unhealthy_threshold" {
  type = number
}
variable "target_group_target_type" {
  type = string
}
variable "lb_listener_port" {
  type = number
}
variable "lb_listener_protocol" {
  type = string
}
variable "lb_listener_default_action_type" {
  type = string
}
variable "security_group_ecs_service_name" {
  type = string
}
variable "security_group_ecs_service_from_port" {
  type = number
}
variable "security_group_ecs_service_to_port" {
  type = number
}
variable "security_group_ecs_service_protocol" {
  type = string
}
variable "security_group_ecs_service_cidr_blocks" {
  type = list(string)
}
variable "ingress_rule_3000_description" {
  type = string
}
variable "ingress_rule_3000_ip_protocol" {
  type = string
}
variable "ingress_rule_3000_from_port" {
  type = number
}
variable "ingress_rule_3000_to_port" {
  type = number
}
variable "ecs_service_sts_name" {
  type = string
}
variable "ecs_service_sts_launch_type" {
  type = string
}
variable "ecs_service_sts_desired_count" {
  type = number
}
variable "ecs_service_sts_nc_assign_public_ip" {
  type = bool
}
variable "ecs_service_sts_lb_container_name" {
  type = string
}
variable "ecs_service_sts_lb_container_port" {
  type = number
}