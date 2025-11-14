TITLE Somatória de 5 números
.MODEL SMALL
.DATA ;salva as springs em .DATA
    MSG_NUM DB 'Digite um numero: $'
    MSG_RES DB 'O resultado foi $'
.CODE
 MAIN PROC
    ;libera acesso ao .DATA 
    MOV AX, @DATA
    MOV DS, AX
    
    MOV CL, 5; inicia o contador com a quantidade de repetições

Calculo:
    ;Imprime a mensagem em cada loop 
    MOV AH, 9
    LEA DX, MSG_NUM
    INT 21H
    ;salva o caracter digitado em cada loop
    MOV AH, 1
    INT 21H

    SUB AL, 48 ;subtrair 48 para conseguir fazer a soma decimal naturalmente 
    ADD BL, AL ;soma em BL para salvar os números e dar o resultado

    MOV AH, 2 ; imprime line feed para melhor visualização no terminal
    MOV DL, 10
    INT 21H

    LOOP Calculo ;inicia loop até CX estar zerado

    ADD BL, 48 ;adiciona 48 de volta para igualar na tabela ASCII

    MOV AH, 9 ;imprime mensagem de resultado
    LEA DX, MSG_RES
    INT 21H

    MOV AH, 2 ; imprime o resultado
    MOV DL, BL
    INT 21H

    MOV AH, 4Ch ; finaliza o programa
    INT 21H

 MAIN ENDP
END MAIN