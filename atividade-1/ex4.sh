#!/bin/bash

# Coleta o nome do usuário
echo "Qual o seu nome?"
read nome

# Obtém as informações de data e hora
dia_semana=$(date +%A)
mes=$(date +%B)
hora=$(date +%H)
minuto=$(date +%M)
segundo=$(date +%S)
hora_completa=$(date +%H:%M:%S)
ano=$(date +%Y)

# Exibe as informações formatadas
echo "Hoje é: $dia_semana"
echo "Estamos no mês de: $mes"
echo "Agora é: $hora horas"
echo "Com: $minuto minutos"
echo "e $segundo segundos"
echo "ou seja, $hora_completa"
echo "Estamos no ano de $ano"
echo "Autor: $nome"
