# Single wildcard certificate instead of per-app certificates

We issue one wildcard `Certificate` (`*.yourdomain.com`) via the DNS-01 `ClusterIssuer` (see [[0005-cert-manager-dns01-cloudflare]]) rather than a separate certificate per app/hostname. Chosen because this is an internal-only, single-tenant homelab — the per-app blast-radius/revocation argument doesn't apply — and it means every new service just gets a hostname under the existing `Gateway` listener with no new cert machinery or DNS-01 round-trip.
