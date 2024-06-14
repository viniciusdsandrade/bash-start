#!/bin/bash

echo "Qual o seu nome: "
read nome

echo "Olá $nome, tudo bem?"
echo ""
echo "Lista da sua agenda:"
cat agenda_tel.txt  # Exibe o conteúdo do arquivo
echo ""
