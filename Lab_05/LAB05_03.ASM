TITLE Imprime letras
.MODEL SMALL
.CODE
 MAIN PROC
    
    MOV CX, 26 ; inicia o contador com o numero de repetições, nesse caso 26 (numero de letras)
    MOV DL, 'A' ;inicia DL com 'A'

    Maiusculas:

    MOV AH, 2 ; imprime o que está em DL
    INT 21H
    INC DL ;incrementa DL para ir pra próxima letra
    LOOP Maiusculas ; decrementa CX e pula para o rotulo maiscula, até CX ser 0

    MOV AH, 2 ; imprime carrige return para melhor visualização no terminal 
    MOV DL, 10
    INT 21H

    MOV CX, 26 ; inicia o contador co o numero de repetições
    MOV DL, 'a'; inicia Dl com 'a'

    Minusculas:

    MOV AH, 2 ; imprime o que está em Dl
    INT 21H
    INC DL ; incrementa Dl para ir pra próxima letra
    LOOP Minusculas ; decrementa CX e pula para o rotulo minusculas, até CX ser 0

    MOV AH, 4Ch ; finaliza o programa
    INT 21H
 MAIN ENDP
END MAIN
