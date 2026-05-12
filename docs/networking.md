# Networking

O modulo `terraform/modules/network` cria:

- VCN dedicada por ambiente.
- Subnet publica para bastion/recursos expostos quando necessario.
- Subnet privada para OKE workers.
- Subnet de Load Balancer.
- Internet Gateway, NAT Gateway e Service Gateway.
- NSGs para Load Balancer e workers.

## Padrao de trafego

- Entrada publica: HTTPS/HTTP no Load Balancer.
- Workers: sem IP publico, saida via NAT Gateway.
- Acesso a servicos OCI: Service Gateway.
- Administracao: Bastion e kubeconfig com endpoint privado.
- Bastion: liberar apenas CIDRs administrativos em `bastion_allowed_cidrs`.

Antes de producao, restrinja CIDRs de entrada, use TLS real e avalie WAF no Load Balancer.
