# 05 — Cloudflare DNS-01 ClusterIssuer

**What to build:** A production Let's Encrypt `ClusterIssuer` that can complete DNS-01 challenges against Cloudflare, using the token pulled from Azure Key Vault (per [[0005-cert-manager-dns01-cloudflare]] — production only, no staging issuer).

**Blocked by:** 02 (cert-manager), 04 (ESO wired to Azure Key Vault, Cloudflare token available there)

**Status:** ready-for-agent

- [ ] An `ExternalSecret` pulls the Cloudflare API token from Key Vault into a Kubernetes `Secret` usable by cert-manager
- [ ] A Let's Encrypt **production** `ClusterIssuer` configured for the DNS-01 challenge via the Cloudflare solver, referencing that secret
- [ ] The `ClusterIssuer` reaches status `Ready`
