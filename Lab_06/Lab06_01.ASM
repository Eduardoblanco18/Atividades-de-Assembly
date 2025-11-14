TITLE IMPRIME *
.MODEL SMALL
.DATA
    MSG1 DB "Escreva um caractere: $"
    MSGAVISO DB "Dar enter vai fazer com que pare a contagem!$"
.CODE
 MAIN PROC
    ;zera o valor de CX
    XOR CX, CX
    ;libera o acesso ao .DATA
    MOV AX, @DATA
    MOV DS, AX
    ;imprime o aviso
    MOV AH, 9
    LEA DX, MSGAVISO
    INT 21H
    ;imprime line feed
    MOV AH, 2
    MOV DL, 10
    INT 21H
    ;imprime o 1ª mensagem
    MOV AH, 9
    LEA DX, MSG1
    INT 21H
    ;função de copiar o caracter digitado
    MOV AH, 1
 COPIAR: ; rotulo para o loop
    INT 21H ;realiza a função
    ;compara o caracter com carriege return
    CMP AL, 13 ; compara com carriege return
    JE SAIDA ; se for igual, pula para imprimir
    INC CX ; aumenta o contador caso n seja igual
    JMP COPIAR ; pula para COPIAR para pegar outro caractere
 SAIDA: ;rotulo para imprimir
    MOV AH, 2 ; função de imprimir caracter
    MOV DL, "*" ; salva DL com o valor de *
 IMPRIME: ;rotulo do loop para imprimir diversas vezes
    INT 21H ; imprime o *
    LOOP IMPRIME ;DEC CX JNE IMPRIME, faz essa comparção assim repetindo a quantidade de vezes que são necessárias
    ; retorna para o sistema operacional
    MOV AH, 4Ch
    INT 21H
 MAIN ENDP
END MAIN