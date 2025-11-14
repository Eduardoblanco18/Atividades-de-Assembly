TITLE Numero
.MODEL SMALL
.STACK 100h
.DATA
    ;guarda as mensagens/strings em .DATA
    MSG1 DB "Digite um caractere: $"
    SIM DB 10, 13,"O carctere digitado eh um numero.$"
    NAO DB 10, 13,"O caractere digitado nao eh um numero.$"
.CODE
 MAIN PROC
    ;pega as strings e guarda em DS
    MOV AX, @DATA
    MOV DS, AX
    ;função de imprimit strings
    MOV AH, 9
    LEA DX, MSG1
    INT 21h
    ;função de copiar caracter digitado 
    MOV AH,1
    INT 21h
    ;guarda o caracter em BL
    MOV BL, AL
    ;Compara BL com o '0', na tabela ASCII. em outras palavras faz caracter de BL - 48
    CMP BL, 48
    ;Se o resultado for menor que 0, pula pra linha de rotulo 'NAONUMERO'
    JB NAOENUMERO
    ;agr compara com o '9'
    CMP BL, 57
    ;Se for maior que 0, a comparação pula para 'NAONUMERO'
    JA NAOENUMERO 
    ;caso tenha dado maior que '0' e menor que '9' então eh um número! função 9 pra escrever isso.
    MOV AH, 9
    LEA DX, SIM
    INT 21h
    ;pula pro rotulo fim, final do programa
    JMP FIM

NAOENUMERO:
    ; caso a comparação de que n eh um numero, função 9 pra escrever que n eh um numero 
    MOV AH, 9
    LEA DX, NAO
    INT 21h

FIM:
    ;finalização do programa
    MOV AH, 4Ch
    INT 21h
 MAIN ENDP 
END MAIN