#! /bin/bash

diretorio=$1
opt=$2
ext1=$3
ext2=$4

if [ $# -lt 4 ]; then
    echo "Entre com os 4 argumentos corretamente"
    exit

elif [ ! -d $1 ]; then
    echo "Entre com um diretório válido"
    exit
fi

files=$(ls $diretorio | egrep "$ext1$")

if [ "$opt" = "-c" ]; then
    for i in $files; do
        cp $diretorio/$i $diretorio/${i/$ext1/$ext2}
    done

elif [ "$opt" = "-m" ]; then
	for i in $files; do
	    mv $diretorio/$i $diretorio/${i/$ext1/$ext2}
	done
else
    echo "Entre com uma opção para cópia ou mover válida"
    exit
fi
