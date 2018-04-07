#!/bin/bash
#set -x

# Esse script fornece informacoes sobre um arquivo.

FILENAME="$1"

echo "Propriedades de $FILENAME:"

if [ -f $FILENAME ]; then
  echo "Tamanho: $(ls -lh $FILENAME | awk '{ print $5 }')"
  echo "Tipo: $(file $FILENAME | cut -d":" -f2 -)"
  echo "Numero de Inode: $(ls -i $FILENAME | cut -d" " -f1 -)"
  echo "$(df -h $FILENAME | grep -v Mounted | awk '{ print "Em",$1", \
que esta montado como particao ",$6}')"
else
  echo "Arquivo nao existe."
fi
