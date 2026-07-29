# 02 — Deploy cert-manager

**What to build:** cert-manager is running in the cluster with its CRDs available, ready for an issuer to be configured against it later.

**Blocked by:** None — can start immediately

**Status:** ready-for-agent

- [ ] cert-manager deployed via an Argo CD `Application` using the **official cert-manager Helm chart**, following this repo's app-of-apps pattern
- [ ] cert-manager CRDs installed (`Certificate`, `ClusterIssuer`, `Issuer`, `CertificateRequest`, ...)
- [ ] cert-manager pods `Running`, Argo CD `Application` `Synced` and `Healthy`
- [ ] No `ClusterIssuer` configured yet — that's a later ticket ([[05-cloudflare-dns01-clusterissuer]])
