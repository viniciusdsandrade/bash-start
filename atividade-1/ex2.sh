#!/bin/bash

echo "Digite o nome do arquivo(Precisa ser igual e com sua extensao):"
read arquivo
if [ -e $arquivo ]
then
    echo "O arquivo existe"
else
    echo "O arquivo não existe"
fi