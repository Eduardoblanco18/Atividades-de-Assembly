TITLE For do C
.MODEL SMALL
.CODE
 MAIN PROC

Repeticao1:
    MOV AH, 2 ; imprime o caracter salvo em DL
    MOV DL, '*' ; inicia DL com o valor de '*'
    INT 21H

    INC CL ; incrementa CL, que estava em 0 
    CMP CL, 32h ; compara com 50 (numero de repetições)
    JB Repeticao1 ; se for menor que 50, pula para o rotulo repeticao1

Repeticao2:
    MOV AH, 2 ;imprime o caracter salvo em DL
    MOV DL, '*' ;inicia DL com o valor de '*'
    INT 21H

    MOV AH, 2 ;imprime o caracter carrige return dentro da repeticao para cada '*' estar em uma linha diferente 
    MOV DL, 10
    INT 21H

    INC CL ; incrementa CL, que dessa vez estava em 50
    CMP CL, 64H ;compara CL com 100 (numero de repetições [50] + o numero que já estava em CL[50])
    JB Repeticao2 ; caso seja menor que 100 pula para o rotulo Repeticao2

    MOV AH, 4Ch ;finaliza o programa
    INT 21H
 MAIN ENDP
END MAIN