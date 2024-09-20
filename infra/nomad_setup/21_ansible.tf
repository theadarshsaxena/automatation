resource "ansible_host" "nomad_servers" {
  inventory_hostname = "nomad-server"
  ansible_user       = "ec2-user"
  ssh_private_key    = file("/home/adarsh/company/infra/base-infra/id_rsa")
  host               = module.ec2_instance_server1.instance_ip
}