module "firewall-cache" {
  source = "../modules/network/core/firewall-security-group"
  namespace = var.namespace
  firewall_name = "firewall-cache-mock-${random_integer.value.id}"
  network_id = "vpc-xxxx"
  tags = var.tags
}


output "firewall-cache" {
  value = module.firewall-cache
}

module "firewall-rule-id" {
  source = "../modules/network/core/firewall-security-group-rule-id-based"
  namespace = var.namespace
  from_port = "6479"
  to_port = "6479"
  source_firewall_id = module.firewall-cache.firewall.id
  firewall-id = module.firewall-cache.firewall.id

}

output "firewall-rule-id" {
  value = module.firewall-rule-id
}

module "firewall-rule-ip" {
  source = "../modules/network/core/firewall-security-group-rule-ip-based"
  namespace = var.namespace
  from_port = "6479"
  to_port = "6479"
  firewall-id = module.firewall-cache.firewall.id

  ip_range_list = [
    "192.168.0.0/16"
  ]
  /*
  Fix - Default local network range.
  https://www.dan.me.uk/ipsubnets?ip=192.168.0.1
     CIDR block   	  IP range (network - broadcast)   	  Subnet Mask   	  IP Quantity
  192.168.0.1/32   	  192.168.0.1 - 192.168.0.1   	  255.255.255.255   	  1
  */

  #ip_range_list = ["192.168.0.1/32"]

}

output "firewall-rule" {
  value = module.firewall-rule-ip
}

