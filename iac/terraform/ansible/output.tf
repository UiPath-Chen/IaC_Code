output "public_ip" {
  description = "vm public ip address"
  value       = module.cvm.public_ip
}


output "cvm_user_password" {
  description = "vm password"
  value       = "root/${var.password}"
}
