resource "aws_security_group" "ec2_security_group" {
    name        = "${var.base_name}-ec2-sg"
    description = "Security group for EC2 instance"

    vpc_id = var.vpc_id

    dynamic "ingress" {
        for_each = var.ingress_ports
        content { 
            from_port   = ingress.value.from_port
            to_port     = ingress.value.to_port
            protocol    = ingress.value.protocol
            cidr_blocks = ingress.value.cidr_blocks
        }
    }
    dynamic "egress" {
        for_each = var.egress_ports
        content {
            from_port   = egress.value.from_port
            to_port     = egress.value.to_port
            protocol    = egress.value.protocol
            cidr_blocks = egress.value.cidr_blocks
        }
    }
    # ingress {
    #     from_port   = 22
    #     to_port     = 22
    #     protocol    = "tcp"
    #     cidr_blocks = ["0.0.0.0/0"]
    # }

    # ingress {
    #     from_port   = 80
    #     to_port     = 80
    #     protocol    = "tcp"
    #     cidr_blocks = ["0.0.0.0/0"]
    # }

    # ingress {
    #     from_port = 3301
    #     to_port = 3301
    #     protocol = "tcp"
    #     cidr_blocks = ["0.0.0.0/0"]
    # }

    # egress {
    #     from_port   = 0
    #     to_port     = 0
    #     protocol    = "-1"
    #     cidr_blocks = ["0.0.0.0/0"]
    # }

    tags = {
        Name = "${var.base_name}-ec2-sg"
    }
}

resource "aws_key_pair" "ec2_key_pair" {
    key_name   = "${var.base_name}-ec2-key"
    public_key = file("/home/adarsh/company/infra/base-infra/id_rsa.pub")
}

resource "aws_instance" "ec2_instance" {
    ami                         = var.ami_id
    instance_type               = var.instance_type
    subnet_id                   = var.subnet_id
    associate_public_ip_address = true
    vpc_security_group_ids      = tolist([aws_security_group.ec2_security_group.id])
    key_name                    = aws_key_pair.ec2_key_pair.key_name
    # ebs_block_device {
    #     device_name = "/dev/xvdf"
    #     volume_size = 30
    #     delete_on_termination = false
    # }
    root_block_device {
        volume_size = 10
    }
    tags = {
        Name = "${var.base_name}-ec2-instance"
    }
}