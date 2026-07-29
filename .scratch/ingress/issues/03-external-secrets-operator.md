# 03 — Deploy External Secrets Operator

**What to build:** External Secrets Operator (ESO) is running in the cluster with its CRDs available, ready for a `ClusterSecretStore` to be configured against it later.

**Blocked by:** None — can start immediately

**Status:** done

- [x] ESO deployed via an Argo CD `Application` using the **official external-secrets Helm chart**, following this repo's app-of-apps pattern
- [x] ESO CRDs installed (`ClusterSecretStore`, `SecretStore`, `ExternalSecret`, ...)
- [ ] ESO pods `Running`, Argo CD `Application` `Synced` and `Healthy`
- [x] No `ClusterSecretStore` configured yet — that's the next ticket ([[04-eso-azure-key-vault]])

## Comments

Config implemented in commit 79e8615 (branch `main`) and validated locally (`helm template` renders all ESO CRDs cleanly; no live cluster access from this devcontainer). The pods-Running/Synced-Healthy checkbox is cluster-runtime state and needs confirming once Argo CD actually syncs this on the real Talos node.
