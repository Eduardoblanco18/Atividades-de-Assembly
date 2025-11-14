TITLE Eco
.MODEL SMALL ;N precisa de .DATA pq n tem strings 
.CODE
 MAIN PROC
    ;Função de escrever um caracter
    MOV AH,2
    MOV DL,'?';Cuidado com as aspas e escrever apenas 1 caracter
    INT 21h
    ;Função de ler um caracter do teclado (salva o caracter em AL, em hexadecimal(ler tabela ASCII))
    MOV AH,1
    INT 21h
    ;Copia o caracter digitado na função anterior e copia em BL
    MOV BL,AL
    ;Utiliza a função de exibir um caracter para ir para linha de baixo
    MOV AH,2
    MOV DL,10 ; O código ASCII do caracter Line Feed é 10 (0Ah)
    INT 21h
    ;Utiliza a função de exibir um caracter para mover o cursor para a esquerda 
    MOV AH,2
    MOV DL,13 ; O código ASCII do caracter Carriage Return é 13 (0Dh)
    INT 21h
    ; função de exibir o caracter para exibir o caracter digitado salvo em BL agr copiado em DL(essencial para a função '2' rodar)
    MOV AH,2
    MOV DL,BL
    INT 21h
    ; Finaliza o programa
    MOV AH,4Ch
    INT 21h
 MAIN ENDP
END MAIN