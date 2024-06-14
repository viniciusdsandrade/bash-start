#!/bin/bash

# Função para validar notas (0 a 10)
validar_nota() {
    while true; do
        read -r -p "$1: " valor
        if [[ "$valor" =~ ^[0-9]+$ ]] && (( valor >= 0 && valor <= 10 )); then
            echo "$valor"
            break
        else
            echo "Nota inválida. Digite um valor entre 0 e 10."
        fi
    done
}

# Função para validar faltas (não negativo)
validar_faltas() {
    while true; do
        read -r -p "$1: " valor
        if [[ "$valor" =~ ^[0-9]+$ ]] && (( valor >= 0 )); then
            echo "$valor"
            break
        else
            echo "Quantidade de faltas inválida. Digite um valor não negativo."
        fi
    done
}

# Função para validar nome (2 a 100 caracteres)
validar_nome() {
    while true; do
        read -r -p "Nome do aluno: " nome
        tamanho=${#nome}  # Calcula o tamanho do nome corretamente
        if (( tamanho >= 2 && tamanho <= 100 )); then
            echo "$nome"
            break
        else
            echo "Nome inválido. Digite um nome com 2 a 100 caracteres."
        fi
    done
}

# Função para imprimir uma linha formatada
imprimir_linha() {
    printf "%-35s %-7s %-7s %-7s %-7s %s\n" "$1" "$2" "$3" "$4" "$5" "$6"
}

# Cria ou sobrescreve o arquivo alunos.txt
> "alunos.txt"

# Escreve o cabeçalho no arquivo
imprimir_linha "Nome" "Nota1" "Nota2" "Média" "Faltas" "Situação" >> "alunos.txt"

# Loop principal para inserir dados dos alunos
while true; do
    nome=$(validar_nome)
    if [ "$nome" == "sair" ]; then
        break
    fi

    nota1=$(validar_nota "Nota 1")
    nota2=$(validar_nota "Nota 2")
    faltas=$(validar_faltas "Faltas")

    media=$(awk -v n1="$nota1" -v n2="$nota2" 'BEGIN {printf "%.2f", (n1 + n2) / 2}')

     # Lógica de aprovação/reprovação corrigida (sem bc)
     if awk -v media="$media" 'BEGIN {exit (media < 6)}'; then  # Inverte a lógica do awk
         situacao="Reprovado por média"
     elif (( faltas >= 20 )); then
         situacao="Reprovado por falta"
     else
         situacao="Aprovado"
     fi

    imprimir_linha "$nome" "$nota1" "$nota2" "$media" "$faltas" "$situacao" >> "alunos.txt"
done

# Calcula a média geral das médias (ignorando o cabeçalho)
media_geral=$(awk 'NR>1 {sum+=$4; count++} END {if (count>0) printf "%.2f\n", sum/count}' "alunos.txt")

# Adiciona a média geral ao final do arquivo (usando a função imprimir_linha)
echo "-------------------------------------------------------------------------" >> "alunos.txt"
imprimir_linha "" "" "" "Média geral das médias:" "$media_geral" "" >> "alunos.txt"

# Imprime o conteúdo do arquivo
echo "Conteúdo do arquivo 'alunos.txt':"
cat "alunos.txt"

echo "Dados dos alunos e média geral salvos em alunos.txt"
