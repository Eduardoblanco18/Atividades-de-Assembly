TITLE Arruma vetor em ordem crescente
.MODEL SMALL 
.STACK 100H
.DATA
    QUAISNUM DB "ESCREVA SUA MATRIZ: $"
    MATRIZ DB 1,2,3,4
           DB 4,3,2,1
           DB 5,6,7,8
           DB 8,7,6,5
    IMPVET DB "AQUI ESTA O SUA MATRIZ: $"
.CODE 
 MAIN PROC
    ;inicializo DS
    MOV AX, @DATA
    MOV DS, AX  

    CALL IMPRIMEMATRIZ ;imprimo a matriz do usuario
    ;finalizo o programa
    MOV AH, 4CH
    INT 21H
 MAIN ENDP 

 IMPRIMEMATRIZ PROC
    ;FUNÇÃO PARA IMPRIMIR A MATRIZ
    ;ENTRADA: MATRIZ SALVA
    ;SAIDA: MATRIZ IMPRESSA NO TERMINAL
    MOV AH, 2 ; inicializo a função de imprimir e zero o contador e endereçamento
    XOR CX,CX
    XOR BX,BX
    
    IMPRIMECOLUNA:
    MOV CX, 4 ;cada linha tem 4 "itens"
    XOR SI,SI ;zero SI para endereçamento
    
    IMPRIMELINHA: ; imprimo a linha incrementando SI e colocando espaços entre os itens
    MOV DL, MATRIZ[BX][SI]
    ADD DL, 30H
    INT 21H
    MOV DL, ' '
    INT 21H
    INC SI
    LOOP IMPRIMELINHA
    
    MOV DL, 10 ;line feed para fazer parecer uma Matriz
    INT 21H
    ADD BX, 4
    CMP BX, 12
    JBE IMPRIMECOLUNA
    
    RET
 IMPRIMEMATRIZ ENDP
END MAIN