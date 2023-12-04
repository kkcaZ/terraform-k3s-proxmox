provider "helm" {
    kubernetes {
        config_path = var.helm_config_path
    }
}

provider "kubernetes" {
    config_path = var.helm_config_path
}