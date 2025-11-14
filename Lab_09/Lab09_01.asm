TITLE Arruma vetor em ordem crescente
.MODEL SMALL 
.STACK 100H
.DATA
    QUAISNUM DB "ESCREVA SEU VETOR: $"
    VET DB 7 DUP(?)
    IMPVET DB "AQUI ESTA O SEU VETOR INVERTIDO: $"
.CODE 
 MAIN PROC
    ;inicializo DS
    MOV AX, @DATA
    MOV DS, AX  
    ;chamda de procedimento
    CALL ESCREVEVET
    ;chamada de procedimento
    CALL ORGANIZAVET
    ;chamada de procedimento
    CALL IMPRIMEVET
    ;finalizo o programa
    MOV AH, 4CH
    INT 21H
 MAIN ENDP 

 ESCREVEVET PROC
    ;FUNÇÃO QUE PEGA O NÚMERO QUE O USUARIO ESCREVEU E SALVA NO VETOR
    ;ENTRADA: NENHUMA
    ;SAÍDA: VETOR
    MOV AH, 1 ;preparo função contador e endereçameto para salvar os números do vetor
    MOV CX, 7
    XOR BX, BX

    SALVA: ; salvo os números incrementando BX para ir para próxima casa
    INT 21H
    MOV VET[BX], AL
    INC BX
    LOOP SALVA 

    RET
 ESCREVEVET ENDP

 ORGANIZAVET PROC
    ;FUNÇÃO QUE ORGAIZA O VETOR DE MODO INVERSO, OU SEJA O PRIMEIRO VIRA O ÚLTIMO E O ÚLTIMO VIRA O PRIMEIRO
    ;ENTRADA: VETOR ORIGINAL
    ;SAIDA: VEOTR ALTERADO 
    MOV CX, 4 ;altero até a metade do vetor (a outra metade já foi alterada durante o processo)

    XOR BX, BX ;zero BX e salvo a úlima casa em SI
    MOV SI, 6

    ALTERA: ;altero os valores utilizando AL como mediador
    MOV AL, VET[BX]
    XCHG AL, VET[SI]
    XCHG AL, VET[BX]
    INC BX
    DEC SI
    LOOP ALTERA

    RET
 ORGANIZAVET ENDP

 IMPRIMEVET PROC
    ;procedimento que imprime o vetor
    ;ENTRADA: o vetor salvo no .DATA
    ;SAIDA: impressão no terminal

    MOV CX, 7 ;salvo em CX o tamanho do vetor para impressão

    MOV AH, 2 ;imprimo Line Feed para melhor vizualiação 
    MOV DL, 10
    INT 21H

    MOV AH, 9   ;imprimo a mensagem de IMPVET
    LEA DX, IMPVET
    INT 21H

    XOR BX,BX ; zero BX para acessar as posições 

    MOV AH, 2 ;função de imprimir
    IMPRIME:
    MOV DL, VET[BX] ;imprimo o valor númerico de BX do vetor
    INT 21H

    MOV DL, ' ' ;imprimo um espaço para melhor vizualição
    INT 21H

    INC BX  ;incremento e comparo BX com CX, se menor continua o loop
    CMP BX, CX
    JB IMPRIME

    RET
 IMPRIMEVET ENDP
END MAIN