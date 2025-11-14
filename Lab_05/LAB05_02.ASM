TITLE Uso do loop 
.MODEL SMALL
.CODE 
 MAIN PROC

    MOV CX, 50 ;inicia o contador com o numero de repetições do loop, nesse caso 50

Imprecao1:

    MOV AH, 2 ;imprime o que está em DL
    MOV DL, '*' ; DL recebe o valor de '*' 
    INT 21H
    LOOP Imprecao1 ;decrementa CX e caso CX diferente de 0 pula para o rotulo imprecao1

    MOV AH, 2 ;imprime o carriege retun para melhor vizualização
    MOV DL, 10
    INT 21H

    MOV CX, 50 ;inicia o contador com o numero de repetições do loop

Imprecao2:

    MOV AH, 2 ; imprime oq está em DL
    MOV DL, '*' ;DL recebe de novo o valor de '*'
    INT 21H

    MOV AH, 2 ; imprime o caracter em DL
    MOV DL, 10 ;carriege retunr dessa vez dentro do loop, pq foi pedido que cada '*' estivesse em uma linha separada
    INT 21H
    LOOP Imprecao2 ; decrementa CX e se for differente de 0, pula para o rotulo imprecao2

    MOV AH, 4Ch ;finaliza o programa
    INT 21H
 MAIN ENDP
END MAIN
