#!/bin/bash
# Salva o conteudo de um diretorio
set -x

data=$(date +%F)
dir=$1
destino=$HOME/backups/

if [ $# != 1 ]; then
  echo "Uso: um argumento que e o diretorio a ser salvo"
  exit  
fi

if [ ! -d $dir ]; then
  echo "O diretorio $dir nao existe"
  exit
fi

# ja temos um diretorio de backup?
if [ -d $destino/$dir-$data ]; then
  echo "Este diretorio ja foi salvo hoje. Sobrescrever?"
  read resposta
  if [ $resposta != 's' ]; then
    exit
  fi
else
  mkdir -p $destino/$dir-$data
fi

cp -R $dir $destino/$dir-$data
echo "Backup do diretorio $dir completo"
