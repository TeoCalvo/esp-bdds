#! /bin/bash

diretorio=$1
opt=$2
ext1=$3
ext2=$4

files=$(ls $diretorio | egrep "$ext1$")

echo $opt

if [ "$opt" = "-c" ]; then
	for i in $files; do
	    cp $diretorio/$i $diretorio/${i/$ext1/$ext2}
	done

elif [ "$opt" = "-m" ]; then
	for i in $files; do
	    mv $diretorio/$i $diretorio/${i/$ext1/$ext2}
	done

fi
