#!/bin/bash

# Verifica se o nome do arquivo de entrada foi fornecido
if [ -z "$1" ]; then
    echo "Uso: $0 <arquivo_entrada>"
    exit 1
fi

arquivo_entrada="$1"
arquivo_saida="resultado.txt"

# Verifica se o arquivo de entrada existe
if [ ! -f "$arquivo_entrada" ]; then
    echo "Arquivo de entrada não encontrado: $arquivo_entrada"
    exit 1
fi

# Lê os valores da segunda coluna (ignorando a primeira linha de cabeçalho)
valores=($(awk 'NR>1 {print $2}' "$arquivo_entrada"))

# Calcula a média
soma=0
for valor in "${valores[@]}"; do
    soma=$((soma + valor))
done
media=$(awk "BEGIN {print $soma / ${#valores[@]}}")

# Calcula a soma dos quadrados das diferenças em relação à média
soma_quadrados=0
for valor in "${valores[@]}"; do
    diferenca=$(awk "BEGIN {print $valor - $media}")
    quadrado=$(awk "BEGIN {print $diferenca * $diferenca}")
    soma_quadrados=$(awk "BEGIN {print $soma_quadrados + $quadrado}")
done

# Calcula a variância e o desvio padrão
variancia=$(awk "BEGIN {print $soma_quadrados / (${#valores[@]} - 1)}")
desvio_padrao=$(awk "BEGIN {print sqrt($variancia)}")

# Exibe os resultados no terminal
echo "Média: $media"
echo "Variância: $variancia"
echo "Desvio Padrão: $desvio_padrao"

# Salva os resultados no arquivo de saída
echo "Média: $media" > "$arquivo_saida"
echo "Variância: $variancia" >> "$arquivo_saida"
echo "Desvio Padrão: $desvio_padrao" >> "$arquivo_saida"

echo "Resultados salvos em $arquivo_saida"