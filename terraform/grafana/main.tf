resource "helm_release" "grafana" {
    name       = "grafana"
    repository = "oci://registry-1.docker.io/bitnamicharts"
    chart      = "grafana"
    version    = "9.1.1"
}

resource "kubernetes_ingress_v1" "grafana_ingress" {
    depends_on = [ helm_release.grafana ]    

    metadata {
        name = "grafana-ingress"
    }
    
    spec {
        rule {
            host = var.grafana_host
            http {
                path {
                    backend {
                        service {
                            name = "grafana"
                            port {
                                number = 3000
                            }
                        }
                    }
                    
                    path = "/"
                }
            }
        }
    }
}