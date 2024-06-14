#!/bin/bash

echo "Digite seu nome: "
read nome
echo "Digite uma qualidade sua: "
read qualidade
echo "Digite um numero de 1 a 10: "
read numero
for ((i=1; i<=numero; i++))
do
    echo "$i. $nome é $qualidade"
done