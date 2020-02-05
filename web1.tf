resource "digitalocean_droplet" "web1" {
  image = "ubuntu-18-04-x64"
  name = "web1"
  region = "sgp1"
  size = "512mb"
  private_networking = true

  ssh_keys = [
    "${var.ssh_fingerprint}"
  ]
  
  connection {
    user = "root"
    type = "ssh"
    // host = "self.public_ip"
    host = "${digitalocean_droplet.web1.ipv4_address}"
    private_key = "${file(var.pvt_key)}"
    timeout = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      // install nginx
      "sudo apt update -y",
      "sudo apt -y install nginx"
    ]
  }
}