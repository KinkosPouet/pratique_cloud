# Création d'une ressource de paire de clés SSH
resource "openstack_compute_keypair_v2" "provision_keypair" {
  provider   = openstack.ovh
  name       = "provision_keypair"
  public_key = file(var.ssh_public_key)
}

resource "openstack_compute_instance_v2" "tp_serveur" {
  count       = var.machine_count
  name        = "server${count.index}" # Nom de l'instance
  provider    = openstack.ovh                # Nom du fournisseur
  image_name  = "Debian 11"                  # Nom de l'image
  flavor_name = "s1-2"                       # Nom du type d'instance
  #
  # Nom de la ressource openstack_compute_keypair_v2 nommée provision_keypair
  key_pair = openstack_compute_keypair_v2.provision_keypair.name

  # Ajoute le composant réseau pour atteindre votre instance
  network {
    name = "Ext-Net"
  }

  provisioner "file" {
    source      = "provision_terra.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    script = "~/cloud/provision_terra.sh"
#   inline = [
#     "chmod +x /tmp/script.sh",
#     "/tmp/script.sh",
#   ]
  }

  # provisioner "local-exec" {
  #   command = "cd ../ansible && ansible-playbook -i inventories/terraform --private-key ${var.ssh_private_key} -e 'pub_key=${var.ssh_public_key}' playbook.yml --limit ${self.name}"
  #   environment = {
  #     ANSIBLE_HOST_KEY_CHECKING = "False"
  #   }
  # }
}
