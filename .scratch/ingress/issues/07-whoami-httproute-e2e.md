# 07 — whoami HTTPRoute + end-to-end verification

**What to build:** The existing `whoami` test app is reachable over HTTPS at a real hostname, proving the entire chain (Gateway API → Traefik → cert-manager → DNS-01 → Cloudflare → Azure Key Vault secret) works together.

**Blocked by:** 06 (wildcard certificate + Gateway ready)

**Status:** ready-for-agent

- [ ] `HTTPRoute` created attaching the existing `whoami` `Service` to the `Gateway` under a real hostname within the wildcard domain
- [ ] `curl https://whoami.<domain>` from the LAN returns the `whoami` response body
- [ ] The TLS chain presented is signed by Let's Encrypt (production), matching the wildcard certificate
