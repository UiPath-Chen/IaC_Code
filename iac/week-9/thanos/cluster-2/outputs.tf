output "kube_config" {
  description = "kubeconfig"
  value       = "${path.module}/config.yaml"
}

output "cvm_public_ip" {
  value = module.cvm_2.public_ip
}

output "ssh_password" {
  value = var.password
}

output "Thanos" {
  value = "${module.cvm_2.public_ip}:30090"
}
