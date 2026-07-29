# 03 — Deploy External Secrets Operator

**What to build:** External Secrets Operator (ESO) is running in the cluster with its CRDs available, ready for a `ClusterSecretStore` to be configured against it later.

**Blocked by:** None — can start immediately

**Status:** ready-for-agent

- [ ] ESO deployed via an Argo CD `Application` using the **official external-secrets Helm chart**, following this repo's app-of-apps pattern
- [ ] ESO CRDs installed (`ClusterSecretStore`, `SecretStore`, `ExternalSecret`, ...)
- [ ] ESO pods `Running`, Argo CD `Application` `Synced` and `Healthy`
- [ ] No `ClusterSecretStore` configured yet — that's the next ticket ([[04-eso-azure-key-vault]])
