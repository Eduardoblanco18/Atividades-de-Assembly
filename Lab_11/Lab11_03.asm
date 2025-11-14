TITLE trnasforma maiuscula em minuscula
.MODEL SMALL
.STACK 100H
.DATA
    tabela  DB "abcdefghijklmonpqrstuvwxyz"
.CODE
 MAIN PROC
    ;inicializo DS
    MOV AX, @DATA
    MOV DS, AX
    ;pego a entrada do usuario
    MOV AH, 1
    INT 21H
    ;coloco o endereço da tabela em BX
    LEA BX, tabela
    call minuscula
    ;imprimo o novo caractere
    MOV DL, AL
    MOV AH, 2
    INT 21H
    ;finalizo o programa
    MOV AH, 4CH
    INT 21H
 MAIN ENDP

 minuscula PROC
    ;transforma uma letra maiuscula em minuscula
    ;entrada: letra maiuscula em AL e tabela em BX
    ;saida: letra minuscula em AL
    ;subtraio o menor valor da tabela em AL e chamo XLAT
    SUB AL, 'a'
    XLAT

    RET ;volto ao ponto de chamada
 minuscula ENDP
END MAIN