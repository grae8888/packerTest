packer {
  required_plugins {
    amazon = {
      version = ">= 1.0.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon_ebs" "grae-test-packer" {
  ami_name = "grae-ami-${local.timestamp}"

  source_ami_filter {
    filters = {
      name                = "amzn2-ami-hvm-2.*.1-x86_64-gp2"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }

  instance_type = "t2.micro"
  region = "ap-southeast-2"
  ssh_username = "ec2-user"
}

build {
  sources = [
    "source.amazon-ebs.grae-test-packer"
  ]

  provisioner "shell" {
    script = "./app.sh"
  }
}
