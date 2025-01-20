#!/bin/bash

# Configurações
DISCO_ORIGEM="/dev/sda"
DESTINO_IMAGEM="/srv/nfs/disk.img"
BLOCO="2M"

# Verifica se o destino existe
if [ ! -d "$(dirname "$DESTINO_IMAGEM")" ]; then
  echo "Diretório de destino não existe. Criando..."
  mkdir -p "$(dirname "$DESTINO_IMAGEM")"
fi

# Criação da imagem
echo "Iniciando criação da imagem de $DISCO_ORIGEM em $DESTINO_IMAGEM..."
dd if="$DISCO_ORIGEM" of="$DESTINO_IMAGEM" bs="$BLOCO" conv=noerror status=progress

# Confirmação
if [ $? -eq 0 ]; then
  echo "Imagem criada com sucesso em $DESTINO_IMAGEM."
else
  echo "Falha ao criar a imagem."
fi
