resource "azurerm_kubernetes_cluster" "AKS" {
    name = var.cluster_name
    location = var.location
    resource_group_name = var.resource_group_name
    dns_prefix = "${resource_group_name}-cluster"

    deafult_node_pool {
        name = 
        node_count = 
        vm_size = 
        max_pods = 
        os_disk_size
    }
}