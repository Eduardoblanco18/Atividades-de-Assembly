TITLE soma de duas matrizes
.MODEL SMALL
.STACK 100H
.DATA 
    N EQU 4
    ENTRADA1    DB "ESCREVA A MATRIZ 1: $"
    ENTRADA2    DB 10, 13, "ESCREVA A MATRIZ 2: $"
    SAIDA       DB 10, 13,"A MATRIZ SOMA É:", 10, 13,'$'
    MATRIZ_1    DB N DUP(N DUP(?))
    MATRIZ_2    DB N DUP(N DUP(?))
    MATRIZ_SOMA DB N DUP(N DUP(?))
.CODE 
    MAIN PROC
        ;inicializo DS
        MOV AX, @DATA
        MOV DS, AX
        ;imprimo menagem de entrada para a primeira matriz
        MOV AH, 9
        LEA DX, ENTRADA1
        INT 21H
        ;salvo o endereço da matriz 1 em BX e chamo função de escrever
        LEA BX, MATRIZ_1
        CALL LER_MATRIZ
        CALL IMPRIMIR_MATRIZ
        ;imprimo menagem de entrada para a segunda matriz
        MOV AH, 9
        LEA DX, ENTRADA2
        INT 21H
        ;salvo o endereço da matriz 2 em BX e chamo função de escrever
        LEA BX, MATRIZ_2
        CALL LER_MATRIZ
        CALL IMPRIMIR_MATRIZ
        ;chamo função de somar as duas matrizes
        CALL SOMAR_MATRIZ
        ;imprimo mensagem de saida
        MOV AH, 9
        LEA DX, SAIDA
        INT 21H
        ;chamo função de imprimir a matriz soma 
        LEA BX, MATRIZ_SOMA
        CALL IMPRIMIR_MATRIZ
        ;finalizo o programa
        MOV AH, 4CH
        INT 21H
    MAIN ENDP

    LER_MATRIZ PROC
        ;procedimento de pegar input do usuario e salvar em uma matriz N*N
        ;entrada: endereço da matriz a salvar em BX
        ;saida: matriz salva na memoria
        PUSH BX ;salvo a entrada para usa-la depois 
        
        MOV DX, N ;coloco o limite de linhas em DX e inicializo a função 1
        MOV AH, 1
        
        LER_LINHA:
        XOR SI, SI ;zero o endereçamento de SI, e coloco o limite de colunas em CX
        MOV CX, N
        
        LER_COLUNA: ;leio o input do usuario, trnasformo em número e salvo na matriz em BX
        INT 21H
        AND AL, 0FH
        MOV [BX][SI], AL
        INC SI ;incremento si, para ir para coluna do lado
        LOOP LER_COLUNA
        ADD BX, N ;somo N, em BX para ir para proxima linha
        DEC DX
        JNZ LER_LINHA

        POP BX
        RET ;retorno ao ponto de chamada
    LER_MATRIZ ENDP

    SOMAR_MATRIZ PROC
        ;procedimento de somar as duas matrizes
        ;entrada: nenhuma
        ;saida: matriz soma salva
        LEA BX, MATRIZ_1 ;salvo o endreço de todas as matrizes nos registradores BX, AX e DI
        LEA AX, MATRIZ_2
        LEA DI, MATRIZ_SOMA

        MOV DX, N ;contador externo em DX

        SOMAR_LINHA:
        PUSH DX ;salvo o contador externo, zero SI e inicializo contador interno
        XOR SI, SI
        MOV CX, N
        
        SOMAR_COLUNA:
        MOV DL, [BX][SI] ;faço a soma e salvo em Matriz_Soma
        XCHG BX, DI
        MOV [BX][SI], DL
        XCHG BX, DI
        XCHG AX, BX
        MOV DL, [BX][SI]
        XCHG AX, BX
        XCHG BX, DI
        ADD [BX][SI], DL
        XCHG BX, DI

        INC SI ;incremento SI para ir para proxima coluna
        LOOP SOMAR_COLUNA
        ADD BX, N ;adiciono N para os registradores para ir para proxima linha
        ADD AX, N
        ADD DI, N
        POP DX
        DEC DX
        JNZ SOMAR_LINHA

        RET ;retono ao ponro de chamada
    SOMAR_MATRIZ ENDP

    IMPRIMIR_MATRIZ PROC
        ;procedimento para imprimir matriz salva
        ;entrada: endeerço da matriz a ser imprimida
        ;saida: matriz impressa no terminal
        PUSH BX ;salvo a entrada para usa-la depois 

        MOV DH, N ;coloco o limite de linhas em DX e inicializo a função 1
        MOV AH, 2
        MOV DL, 10
        INT 21H
        
        IMPRIMIR_LINHA:
        XOR SI, SI ;zero o endereçamento de SI, e coloco o limite de colunas em CX
        MOV CX, N
        
        IMPRIMIR_COLUNA: ;leio o input do usuario, trnasformo em número e salvo na matriz em BX
        MOV DL, [BX][SI]
        OR DL, 30H
        INT 21H
        INC SI ;incremento si, para ir para coluna do lado
        MOV DL, ' '
        INT 21H
        LOOP IMPRIMIR_COLUNA
        MOV DL, 10
        INT 21H
        ADD BX, N ;somo N, em BX para ir para proxima linha
        DEC DH
        JNZ IMPRIMIR_LINHA

        POP BX
        RET ;retono ao ponto de chamada
    IMPRIMIR_MATRIZ ENDP
END MAIN