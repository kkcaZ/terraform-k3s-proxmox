resource "kubernetes_namespace" "jx-vault" {
    metadata {
        name = "jx-vault"
    }
}

resource "helm_release" "vault-operator" {
    depends_on = [ kubernetes_namespace.jx-vault ]
    name       = "vault-operator"
    repository = "oci://ghcr.io/bank-vaults/helm-charts"
    namespace  = "jx-vault"
    chart      = "vault-operator"
    version    = "1.20.0"
}

resource "helm_release" "vault-instance" {
    depends_on = [ helm_release.vault-operator ]
    name       = "vault-instance"
    repository = "https://jenkins-x-charts.github.io/repo"
    namespace  = "jx-vault"
    chart      = "vault-instance"
    version    = "1.0.27"
}