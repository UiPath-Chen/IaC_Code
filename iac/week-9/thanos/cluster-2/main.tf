# cluster-1
module "cvm_2" {
  source     = "../../../module/cvm"
  secret_id  = var.secret_id
  secret_key = var.secret_key
  password   = var.password
}

module "k3s_2" {
  depends_on  = [module.cvm_1]
  source      = "../../../module/k3s"
  public_ip   = module.cvm_1.public_ip
  private_ip  = module.cvm_1.private_ip
  server_name = "k3s-hongkong-1"
}


resource "local_sensitive_file" "kubeconfig" {
  content  = module.k3s_2.kube_config
  filename = "${path.module}/config.yaml"
}