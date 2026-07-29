# 04 — Wire ESO to Azure Key Vault

**What to build:** External Secrets Operator can fetch secrets out of an existing Azure Key Vault, authenticating via a Service Principal (per [[0006-external-secrets-azure-key-vault]]), and the Cloudflare API token needed by cert-manager exists as a secret there.

**Blocked by:** 03 (External Secrets Operator must be running)

**Status:** ready-for-agent

- [ ] Azure App Registration / Service Principal created, scoped to read-only access on the target Key Vault
- [ ] Service Principal's `clientId`/`clientSecret`/`tenantId` applied to the cluster **manually** (`kubectl apply`) as a one-off bootstrap `Secret` — never committed to git, never synced by Argo CD
- [ ] `ClusterSecretStore` configured with `authType: ServicePrincipal`, referencing the bootstrap secret, reaches status `Valid`
- [ ] Cloudflare API token stored as a secret entry in the Azure Key Vault
- [ ] A test `ExternalSecret` successfully fetches that token from Key Vault into a Kubernetes `Secret`, proving the path end-to-end
