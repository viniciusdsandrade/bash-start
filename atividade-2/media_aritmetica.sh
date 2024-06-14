#!/bin/bash

# Solicita ao usuário a quantidade de números
while true; do
    echo "Quantos números você deseja inserir? (deve ser um número inteiro positivo)"
    read quantidade
    # Verifica se a entrada é um número inteiro positivo
    if [[ $quantidade =~ ^[1-9][0-9]*$ ]]; then
        break  # Sai do loop se a entrada for válida
    else
        echo "Entrada inválida. Por favor, insira um número inteiro positivo."
    fi
done

# Declara um array para armazenar os números
declare -a numeros

# Loop para coletar os números do usuário com validação
for (( i=0; i<$quantidade; i++ )); do
    while true; do
        echo "Digite o número $((i+1)): "
        read num
        # Verifica se a entrada é um número (inteiro ou decimal)
        if [[ $num =~ ^-?[0-9]+([.][0-9]+)?$ ]]; then
            numeros[$i]=$num  # Armazena o número no array
            break  # Sai do loop se a entrada for válida
        else
            echo "Entrada inválida. Por favor, insira um número válido."
        fi
    done
done

# Calcula a soma dos números
soma=0
for num in "${numeros[@]}"; do
    soma=$(echo "scale=2; $soma + $num" | bc)  # Usa bc para precisão decimal
done

# Calcula a média aritmética
media=$(echo "scale=2; $soma / $quantidade" | bc)

# Exibe os resultados
echo "A soma dos números é: $soma"
echo "A média aritmética é: $media"
