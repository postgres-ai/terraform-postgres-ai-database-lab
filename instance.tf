data "template_file" "init" {
  template = "${file("dle-logical-init.sh.tpl")}"
  vars = {
    dle_token = "${var.dle_token}"
    dle_debug = "${var.dle_debug}"
    dle_retrieval_refresh_timetable = "${var.dle_retrieval_refresh_timetable}"
    dle_disks = "${join(" ",var.ec2_ebs_names)}"
    dle_version_short = "${var.dle_version_short}"
    dle_version_full = "${var.dle_version_full}"
    postgres_source_dbname = "${var.postgres_source_dbname}"
    postgres_source_host = "${var.postgres_source_host}"
    postgres_source_port = "${var.postgres_source_port}"
    postgres_source_username = "${var.postgres_source_username}"
    postgres_source_password = "${var.postgres_source_password}"
    postgres_source_version = "${var.postgres_source_version}"
  }
}

resource "aws_instance" "aws_ec2" {
  ami               = "${data.aws_ami.ami.id}"
  availability_zone = "${var.availability_zone}"
  instance_type     = "${var.instance_type}"
  security_groups   = ["${aws_security_group.dle_instance_sg.name}"]
  key_name          = "${var.keypair}"
  tags              = "${local.common_tags}"
  user_data         = "${data.template_file.init.rendered}"

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = "${file("test.pem")}"
    host        = "${self.public_ip}"
  }

#  provisioner "file" {
#    source      = "example.com.key"
#    destination = "/tmp/example.com.key"
#  }
#  provisioner "file" {
#    source      = "postgres.example.com.csr"
#    destination = "/tmp/postgres.example.com.csr"
#  }
  provisioner "remote-exec" {
    inline = [
      "sudo certbot certonly --standalone -d demo-api-engine.aws.postgres.ai -m m@m.com --agree-tos -n",
      "sudo cp /etc/letsencrypt/archive/demo-api-engine.aws.postgres.ai/fullchain1.pem /etc/envoy/certs/",
      "sudo cp /etc/letsencrypt/archive/demo-api-engine.aws.postgres.ai/privkey1.pem /etc/envoy/certs/",
      "sudo systemctl enable envoy",
      "sudo systemctl start envoy"
    ]
  }
}
