TITLE IMPRIME *
.MODEL SMALL
.DATA
    MSG1 DB "Escreva um caractere: $"
    MSGAVISO DB "Dar enter vai fazer com que pare a contagem!$"
.CODE
 MAIN PROC
    XOR CX, CX
    ;libera acesso ao .DATA
    MOV AX, @DATA
    MOV DS, AX
    ;escreve o aviso
    MOV AH, 9
    LEA DX, MSGAVISO
    INT 21H
    ;escreve o caractere line feed
    MOV AH, 2
    MOV DL, 10
    INT 21H
    ;escreve a 1ª mensagem
    MOV AH, 9
    LEA DX, MSG1
    INT 21H
    ;função de copiar caractere digitado 
    MOV AH, 1
 DIGITA:
    INT 21H ; copia o caractere
    INC CX ; incrementa CX
    CMP AL, 13 ; compara AL com carriege return
    JE SAIDA ; se for igual vai para a SAIDA
    JMP DIGITA ; se n, copiar outro caractere
 SAIDA: 
    MOV AH, 2 ; função de imprimir caractere
    MOV DL, '*' ;salva * em DL
 IMPRIME:
    INT 21H ; imprime oq está em DL
    LOOP IMPRIME ; decrementa oq está CX, compara com Zero, se for igual saí, se n repete a impreção 
    ;devolve o controle para o sistema operacional
    MOV AH, 4Ch
    INT 21H
 MAIN ENDP
END MAIN

; a diferença deste código para o anterior, é o fato de que neste código a comparação com o carriege return acontece depois do incremento, ou seja, neste código o carriege retunr conta como um dos caracteres digitados. Enquanto no código anterior, o carriege retunr marca o fim da contagem, mas n eh contabilizado. 