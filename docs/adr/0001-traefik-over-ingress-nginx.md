# Use Traefik instead of ingress-nginx

The community `ingress-nginx` project (`kubernetes/ingress-nginx`) reached its retirement point in March 2026 — best-effort maintenance only, no further releases, bug fixes, or security patches ([Kubernetes Steering/Security Response Committee statement](https://www.kubernetes.io/blog/2026/01/29/ingress-nginx-statement/)). We picked Traefik as its replacement: actively maintained, supports both classic `Ingress` and Gateway API, and is already present in this repo (`whoami` test app uses `traefik/whoami`).

_Note: "ingress-nginx" (retired) is a different project from F5's "NGINX Ingress Controller" (`nginx-inc/kubernetes-ingress`, still maintained) — easy to confuse by name._

## Considered options

- **F5 NGINX Ingress Controller** — closest migration path if we wanted to keep nginx-flavored annotations, not chosen since we have no existing nginx-ingress config to preserve.
- **Cilium Gateway API** — would come for free if we adopt Cilium as CNI, but its Gateway API implementation currently lacks a supported `ExternalAuth`/forward-auth filter ([cilium/cilium#45704](https://github.com/cilium/cilium/issues/45704)) and native rate limiting (only via hand-written `CiliumEnvoyConfig`). Not chosen for now — see [[0002-defer-cilium-cni-migration]].
