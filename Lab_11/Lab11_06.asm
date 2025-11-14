TITLE inverte palavra
.MODEL SMALL
.STACK 100H
.DATA
    NUMBI DB "ESCREVA UM NUMERO EM BINARIO: $"
    NUMINV DB "SEU NUMERO INVERTIDO EH: $"
.CODE
    MAIN PROC
        ;inicializo DS
        MOV AX, @DATA
        MOV DS, AX
        ;imprimo mensagem NUMBI
        MOV AH, 9
        LEA DX, NUMBI
        INT 21H
        ;pego o número em binário
        CALL COPIABINARIO
        ;chamo procedimento para inverter
        CALL INVERTE
        ;imprimo line feed para melhor vizualização
        MOV AH, 2
        MOV DL, 10
        INT 21H
        ;imprimo a mensagem NUMINV
        MOV AH, 9
        LEA DX, NUMINV
        INT 21H
        ;imprimo o número invertido
        CALL SAIDABINARIO
        ;finalizo o programa
        MOV AH, 4CH
        INT 21H
    MAIN ENDP

    COPIABINARIO PROC
        ;PROCEDIOMENTO DE COPIAR UMA STRING DE NÚMERO BINÁRIOS
        ;SEM ENTRADA
        ;SAÍDA STRING DE 0 E 1 EM BX
        MOV AH, 1 ; função de copiar caractere digitado
        XOR CX, CX

        DIGITABI: 
        INT 21H ; realizo a função

        CMP AL, 13 ;comparo com carriege return
        JE SAIbi ; se for igual saio do loop

        SHL BL, 1 ; movo BX uma casa para esquerda

        AND AL, 0FH ;transformo caractere digitado em número

        OR BL, AL ;faço um OR para somar em BL

        INC CX ;incremento CX e comparo com 8 (limite de digitos binários) se for igual sai do procedimento
        CMP CX, 8
        JE SAIbi
        
        JMP DIGITABI ;refaço o loop
        
        SAIbi:
        RET ;retorn ao main
    COPIABINARIO ENDP

    INVERTE PROC
        ;procedimento que inverte uma palavra
        ;entrada: número em BL
        ;saida: número invertido em BL
        ;inicializo o contador com 8
        MOV CX, 8
        ;rotaciono BL para a esquerda e atraves do carry, rotaciono AL para direita
        INVERTE_NUM:
        ROL BL, 1
        RCR AL, 1
        LOOP INVERTE_NUM
        ;coloco o número invertido em BL
        XCHG AL, BL
        RET
    INVERTE ENDP

    SAIDABINARIO PROC
        ;PROCEDIMENTO DE IMPRESSÃO DE NÚMERO BINÁRIO
        ;ENTRADA VALOR SALVO EM BX
        ;SAIDA NO TERMINAL
        ;coloco 8 no contador (8 bits)
        MOV CX, 8
        ;função de imprimir caractere
        MOV AH, 2
        
        IMPRIMEBI:
        ROL BL, 1; rotaciono BX para esquerda em uma casa
        JC IMP1 ;se carry flag == 1, então pula para IMP1

        MOV DL, '0' ; se n, coloco '0' em DL
        JMP IMPBI ;Pula para impressão

        IMP1:;rotulo IMP1
        MOV DL, '1' ;coloco '1' em DL

        IMPBI:
        INT 21H ;realizo a função
        LOOP IMPRIMEBI ;Loop em volta

        RET
    SAIDABINARIO ENDP
END MAIN