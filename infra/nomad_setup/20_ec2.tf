module "ec2_instance_server1" {
    source = "../../modules/ec2"
    base_name = "nomad-server"
    #   ami_id = "ami-085f9c64a9b75eed5"  # Ubuntu 24.04 for us-east-2
    ami_id = "ami-0e86e20dae9224db8"   # Ubuntu 24.04 for us-east-1
    instance_type = "t2.micro"
    subnet_id = "subnet-0b6665ee08118ffb3"
    vpc_id = "vpc-0b26d5de41b05accc"
    ingress_ports = [
        { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
        { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
        { from_port = 4646, to_port = 4646, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
        { from_port = 4647, to_port = 4647, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
        { from_port = 4648, to_port = 4648, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
    ]
    egress_ports = [
        { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
    ]
}

output "instance_ip_server1" {
  value = module.ec2_instance_server1.instance_ip
}

module "ec2_instance_client1" {
    source = "../../modules/ec2"
    base_name = "nomad-client"
    #   ami_id = "ami-085f9c64a9b75eed5"  # Ubuntu 24.04 for us-east-2
    ami_id = "ami-0e86e20dae9224db8"   # Ubuntu 24.04 for us-east-1
    instance_type = "t2.micro"
    subnet_id = "subnet-0b6665ee08118ffb3"
    vpc_id = "vpc-0b26d5de41b05accc"
    ingress_ports = [
        { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
        { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
        { from_port = 4646, to_port = 4646, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
        { from_port = 4647, to_port = 4647, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
        { from_port = 4648, to_port = 4648, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
    ]
    egress_ports = [
        { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
    ]
}

output "instance_ip_client1" {
  value = module.ec2_instance_client1.instance_ip
}