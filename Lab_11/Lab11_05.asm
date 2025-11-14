TITLE multiplicador de portencia
.MODEL SMALL
.STACK 100H
.DATA
    NUM DB "COLOQUE UM NÚMERO: $"
    POT DB 10, 13, "COLOQUE UMA POTENCIA: $"
    NUMMUL DB 10, 13, "SEU NUMERO MULTIPLICADO PELA SUA POTENCIA: $"
.CODE
    MAIN PROC
        ;inicializo DS
        MOV AX, @DATA
        MOV DS, AX
        ;imprimo mensagem NUM 
        MOV AH, 9
        LEA DX, NUM
        INT 21H
        ;pego o número digitado
        CALL digitadecimal
        ;salvo o número digitado
        PUSH AX 
        ;imprimo a mensagem POT
        MOV AH, 9 
        LEA DX, POT
        INT 21H
        ;pego a potencia digitada pelo usuario
        MOV AH, 1
        INT 21H
        AND AX, 000FH
        XCHG AX, CX
        ;retorno o número digitado
        POP AX
        ;chamo o procedimento para multiplicar o número pela potencia
        CALL multiplica
        ;imprimo a mensagem NUMMUL
        MOV AH, 9
        LEA DX, NUMMUL
        INT 21H
        ;imprimo o número multiplicado
        CALL imprimedecimal
        ;finalizo o progama
        MOV AH, 4CH
        INT 21H
    MAIN ENDP

    digitadecimal PROC
        ;O USUARIO ESCREVE UM NÚMERO NA BASE 10
        ;ENTRADA: NENHUMA
        ;SAIDA: NÚMERO SALVO EM AX

        XOR CX, CX ;zero BX CX e DX
        XOR BX, BX
        XOR DX, DX

        MOV AH, 1 ;inicializo função de copiar, e verifico qual foi o primeiro carctere escrito 
        INT 21H
        CMP AL, '-'
        JE negativo
        CMP AL, '+'
        JE positivo
        JMP escrevedecimal
    
        negativo:;se sinal negativo adiciono 1 em cx
        MOV CX, 1
        positivo:
        INT 21H ;se positivo, copio outro número 

        escrevedecimal:
        AND AX, 000FH ;garanto que AX seja só o valor númerico
        PUSH AX ;salvo o número
        MOV AX, 10
        MUL BX ;multiplico BX por 10
        POP BX ;pego o número salvo na pilha e adiciono na em BX 
        ADD BX, AX 

        MOV AH, 1 ;copio próximo número
        INT 21H
        CMP AL, 13 ;se for enter saio do loop
        JNE escrevedecimal

        OR CX, CX ;vejo se CX eh 0 ou 1
        JZ fimentdec
        NEG BX ;se 1, transformo o número em complemento de 2
        fimentdec:
        XCHG AX, BX
        RET ;se n, retorno ao ponto de chamada
    digitadecimal ENDP

    multiplica PROC
        ;procedimento de multiplicar número por potencia de 2
        ;entrada: numero em AL, e potencia em CL
        ;saida: número em BL
        PUSH AX
        PUSH CX
        XOR BX, BX

        SHL AX, CL
        XCHG AX, BX

        POP CX
        POP AX
        RET ;volto para o ponto de chamada
    multiplica ENDP

    imprimedecimal PROC
        ;IMPRIME O NÚMERO EM DECIMAL
        ;ENTRADA: NÚMERO SALVO EM BX
        ;SAIDA: NÚMERO IMPRESSO NA TELA EM BASE 10
        PUSH BX ;salvo o número

        XOR AX,AX ;zero AX

        XCHG AX, BX ;coloco o número em AX
        OR AX, AX ;verifico se é menor que 0
        JGE contimpressao 
        PUSH AX ;se n, salvo o número e imprimo o sinal negativo
        MOV AH, 2
        MOV DL, '-'
        INT 21H
        POP AX ;depois retiro ele da pilha e tiro do complemento de 2
        NEG AX

        contimpressao:
        XOR CX,CX ;zero CX
        OR BX, 10 ;e coloco 10 em BX

        dividenum:
        XOR DX, DX ;zero o resto
        DIV BX ;divido o número pelo 10
        PUSH DX ;salvo o resto
        INC CX
        OR AX, AX ;incremento o contador e verifico se quociente é 0, se sim saio do loop
        JNZ dividenum

        MOV AH, 2 ;inicializo funçaõ de imprimir

        imprimedec:
        POP DX ;retiro o último resto, transformo em carctere núerico e imprimo, até contador ser 0
        OR DL, 30H
        INT 21H
        LOOP imprimedec

        POP BX
        RET ;volto para o ponto de chamada 
 imprimedecimal ENDP
END MAIN