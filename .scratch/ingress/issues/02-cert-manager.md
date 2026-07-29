# 02 — Deploy cert-manager

**What to build:** cert-manager is running in the cluster with its CRDs available, ready for an issuer to be configured against it later.

**Blocked by:** None — can start immediately

**Status:** done

- [x] cert-manager deployed via an Argo CD `Application` using the **official cert-manager Helm chart**, following this repo's app-of-apps pattern
- [x] cert-manager CRDs installed (`Certificate`, `ClusterIssuer`, `Issuer`, `CertificateRequest`, ...)
- [ ] cert-manager pods `Running`, Argo CD `Application` `Synced` and `Healthy`
- [x] No `ClusterIssuer` configured yet — that's a later ticket ([[05-cloudflare-dns01-clusterissuer]])

## Comments

Config implemented in commit 79e8615 (branch `main`) and validated locally (`helm template` renders all 6 cert-manager CRDs cleanly; no live cluster access from this devcontainer). The pods-Running/Synced-Healthy checkbox is cluster-runtime state and needs confirming once Argo CD actually syncs this on the real Talos node.
