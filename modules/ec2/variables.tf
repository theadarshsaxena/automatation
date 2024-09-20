variable "base_name" {
    description = "Naming prefix for all resources"
    type        = string
}

variable "instance_type" {
    description = "Type of EC2 instance"
    type        = string
    default     = "t2.micro"
}

variable "ami_id" {
    description = "AMI ID for the EC2 instance"
    type        = string
}

variable "vpc_id" {
    description = "VPC ID for the Security Group"
    type        = string  
}

variable "subnet_id" {
    description = "Subnet ID for the EC2 instance"
    type        = string
}

variable "ingress_ports" {
  description = "List of ingress ports"
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] },
    { from_port = 3301, to_port = 3301, protocol = "tcp", cidr_blocks = ["0.0.0.0/0"] }
  ]
}

variable "egress_ports" {
  description = "List of egress ports"
  type        = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  default = [
    { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = ["0.0.0.0/0"] }
  ]
}