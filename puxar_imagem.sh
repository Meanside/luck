#!/bin/bash

# Configurações
IMAGEM_ORIGEM="/mnt/nfs/disk.img"
DISCO_DESTINO="/dev/sda"
BLOCO="2M"

# Verifica se a imagem existe
if [ ! -f "$IMAGEM_ORIGEM" ]; then
  echo "Imagem $IMAGEM_ORIGEM não encontrada. Certifique-se de que o NFS está montado corretamente."
  exit 1
fi

# Restauração da imagem
echo "Iniciando restauração da imagem $IMAGEM_ORIGEM para $DISCO_DESTINO..."
dd if="$IMAGEM_ORIGEM" of="$DISCO_DESTINO" bs="$BLOCO" conv=noerror status=progress

# Confirmação
if [ $? -eq 0 ]; then
  echo "Imagem restaurada com sucesso em $DISCO_DESTINO."
else
  echo "Falha ao restaurar a imagem."
fi
