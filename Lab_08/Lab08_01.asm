TITLE Copia um número binário
.MODEL SMALL
.DATA 
    ENTRADA DB "Escreva um digito: $"
    FINALIZAÇÃO DB "O codigo acabou. $"
.CODE 
 MAIN PROC 
    ;Libero acesso ao .DATA
    MOV AX, @DATA
    MOV DS, AX
    ;Limpo BX para usa-lo como armazenador E CX para utiliza-lo como contador
    XOR BX, BX
    XOR CX,CX
    ;imprimo a msg de entrada
    MOV AH, 9
    LEA DX, ENTRADA
    INT 21H
    ;chamo o procedimento de copiar os digitos de um número binário
    CALL COPIA
    ;Imprimo line feed para melhor vizualização no terminal 
    MOV AH, 2
    MOV DL, 10
    INT 21H
    ; imprimo msg de finalização
    MOV AH, 9
    LEA DX, FINALIZAÇÃO
    INT 21H
    ;devolvo controle para o sistema operacional
    MOV AH, 4CH
    INT 21H
 MAIN ENDP

 COPIA PROC
    ;PROCEDIOMENTO DE COPIAR UMA STRING DE NÚMERO BINÁRIOS
    ;SEM ENTRADA
    ;SAÍDA STRING DE 0 E 1 EM BX
    MOV AH, 1 ; função de copiar caractere digitado

DIGITA: 
    INT 21H ; realizo a função

    CMP AL, 13 ;comparo com carriege return
    JE SAI ; se for igual saio do loop

    SHL BX, 1 ; movo BX uma casa para esquerda

    AND AL, 0FH ;transformo caractere digitado em número

    OR BL, AL ;faço um OR para somar em BL

    INC CX ;Incremento CX e comparo com 16(máximo de digitos binários salvoo no registrador) e se for igual saio do procedimento
    CMP CX, 16
    JE SAI
    
    JMP DIGITA ;refaço o loop
SAI:
    RET ;retorn ao main
 COPIA ENDP

END MAIN