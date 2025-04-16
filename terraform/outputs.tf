output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "public_subnets" {
  value = module.vpc.public_subnets  
}

output "application_lb_dns_name" {
  value = aws_lb.lb_application.dns_name
}