#!/bin/bash

# Listar as interfaces de rede disponíveis
echo "Interfaces de rede disponíveis:"
ip -o link show | awk -F': ' '{print $2}'

# Solicitar que o usuário escolha uma interface de rede
read -p "Escolha a interface de rede para configurar (exemplo: ens33, eth0): " INTERFACE

# Validar se a interface escolhida existe
if ! ip a | grep -q "$INTERFACE"; then
  echo "A interface '$INTERFACE' não foi encontrada. Por favor, escolha uma interface válida."
  exit 1
fi

# Definir as configurações IP, Gateway e DNS
read -p "Digite o IP estático (exemplo: 192.168.1.100/24): " IP_ADDRESS
read -p "Digite o Gateway (exemplo: 192.168.1.1): " GATEWAY
read -p "Digite o DNS (exemplo: 8.8.8.8): " DNS

# Diretório do Netplan
NETPLAN_DIR="/etc/netplan"

# Arquivo de configuração do Netplan
CONFIG_FILE="$NETPLAN_DIR/00-installer-config.yaml"

# Criar ou editar o arquivo de configuração do Netplan
echo "network:
  version: 2
  renderer: networkd
  ethernets:
    $INTERFACE:
      dhcp4: no
      addresses:
        - $IP_ADDRESS
      gateway4: $GATEWAY
      nameservers:
        addresses:
          - $DNS" | sudo tee $CONFIG_FILE > /dev/null

# Aplicar as configurações do Netplan
sudo netplan apply

# Exibir a configuração atual da interface de rede
echo "Configuração aplicada com sucesso!"
ip a show $INTERFACE
