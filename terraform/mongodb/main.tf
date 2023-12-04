resource "helm_release" "mongodb" {
    name       = "mongodb"
    repository = "oci://registry-1.docker.io/bitnamicharts"
    chart      = "mongodb"
    version    = "14.0.0"
}