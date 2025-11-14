TITLE imprime matriz e soma conteudo 
.MODEL SMALL
.STACK 100H
.DATA
    escrevematriz DB "ESCREVA SUA MATRIZ: $"
    imprimematriz DB "AQUI ESTA SUA MATRIZ: $"
    somaconteudo  DB "A SOMA DO CONTEUDO DA MATRIZ EH: $"
    matriz        DB 4 dup(4 dup(?))
.CODE
 MAIN PROC
    ;inicializo DS
    MOV AX, @DATA
    MOV DS, AX
    ;peço pro usuario escrever sua matriz
    CALL DIGITAMATRIZ
    ;imprimo line feed para melhor vizualiação
    MOV AH, 2
    MOV DL, 10
    INT 21H
    ;imprimo a matriz
    CALL IMPRESSAOMATRIZ
    ;imprimo line feed para melhor vizualização
    MOV AH, 2
    MOV DL, 10
    INT 12H
    ;faço a soma e imprimo
    CALL SOMAEIMPRESSAO
    ;finalio o programa
    MOV AH, 4CH
    INT 21H
 MAIN ENDP

 DIGITAMATRIZ PROC
    ;FUNÇÃO PRO USUARIO ESCREVER A MATRIZ 
    ;ENTRADA: NENHUMA
    ;SAIDA: MATRIZ SALVA 
    PUSH AX ;salvo os conteudos dos registradores nas pilhas para tira-los ao final do procedimento
    PUSH BX
    PUSH CX
    PUSH SI

    MOV AH, 9 ;imprimo a mensagem para escrever a matriz
    LEA DX, escrevematriz
    INT 21H

    XOR BX,BX ;zero BX e já incializo a função de copiar o que já foi digitado
    MOV AH, 1
    
    DIGITACOLUNA:
    MOV CX, 4 ;como cada linha possui quatro itens inicializo o contador com quatro e zero o endereçamento
    XOR SI,SI
    
    DIGITALINHA: 
    INT 21H ;copio o caractere digitado transformo em numero e jogo na posição correspondente na matriz 
    AND AL, 0FH
    MOV matriz[BX][SI], AL
    INC SI
    LOOP DIGITALINHA

    ADD BX, 4 ;adiciono quatro em BX para ir para proxima linha
    CMP BX, 12
    JBE DIGITACOLUNA

    POP SI
    POP CX
    POP BX
    POP AX
    RET 
 DIGITAMATRIZ ENDP

 IMPRESSAOMATRIZ PROC
    ;FUNÇÃO PRA IMPRIMIR A MATRIZ DO USUARIO
    ;ENTRADA: MATRIZ SALVA
    ;SAIDA: TERMINAL
    PUSH AX ;salvo os conteudos dos registradores nas pilhas para tira-los ao final do procedimento
    PUSH BX
    PUSH CX
    PUSH SI

    MOV AH, 9 ;imprimo a mensagem de impressão de matriz
    LEA DX, imprimematriz
    INT 21H

    XOR BX,BX ;faço a mesma coisa que o procedimento anterior, entretanto dessa vez imprimo os numeros com o devido tabelamento 
    MOV AH, 2
    MOV DL, 10
    INT 21H
    
    IMPRIMECOLUNA:
    MOV CX, 4
    XOR SI,SI
    
    IMPRIMELINHA: 
    MOV DL, matriz[BX][SI]
    ADD DL, 30H
    INT 21H
    MOV DL, ' '
    INT 21H
    INC SI
    LOOP IMPRIMELINHA
    MOV DL, 10
    INT 21H

    ADD BX, 4
    CMP BX, 12
    JBE IMPRIMECOLUNA

    POP SI
    POP CX
    POP BX
    POP AX
    RET 
 IMPRESSAOMATRIZ ENDP

 SOMAEIMPRESSAO PROC
    ;FUNÇÃO PRA SOMAR O CONTEUDO DA MATRIZ E IMPRIMIR 
    ;ENTRADA: MATRIZ SALVA
    ;SAIDA: TERMINAL E SOMA EM DX
    PUSH AX ;salvo os conteudos dos registradores nas pilhas para tira-los ao final do procedimento
    PUSH BX
    PUSH CX
    PUSH SI

    XOR BX,BX ;zero BX para fazer o endereçamento da matriz
    XOR DX, DX ;zero DX para somar o valor
    
    SOMACOLUNA: ;somo o valor de cada espaço da matriz
    MOV CX, 4
    XOR SI,SI
    
    SOMALINHA: 
    MOV AL, matriz[BX][SI]
    ADD DL, AL
    INC SI
    LOOP SOMALINHA

    ADD BX, 4
    CMP BX, 12
    JBE SOMACOLUNA

    MOV BX, DX ;passo a soma para BX
 
    MOV AH, 9 ;imprimo a mensagem de de somar o conteudo
    LEA DX, somaconteudo
    INT 21H

    XOR CX,CX ; zero o contador, passo a soma para AX e testo para ver se eh zero, se for já imprimo
    MOV AX, BX
    TEST AX, AX
    JZ IMPRIMESOMA
    
    MOV BL, 10 ;movimento 10 em BL
    
    DIVIDEPORDEZ:
    DIV BL ;divido AX por BL, incremento CX e coloco o resultado na pilha  
    INC CX
    PUSH AX
    TEST AL, AL ;verifico se o quociente é zero, se sim, imprima a soma, se não, zero AH e recomeço
    JZ IMPRIMESOMA
    XOR AH,AH
    JMP DIVIDEPORDEZ

    IMPRIMESOMA:
    MOV AH, 2 ;inicializo AH com a função de imprimir

    POP DX ;retiro o resultado da ultima divisão da pilha, troco o quociente pelo resto e imprimo até o contador voltar a zero
    XCHG DL, DH
    ADD DL, 30H
    INT 21H

    LOOP IMPRIMESOMA
    

    POP SI
    POP CX
    POP BX
    POP AX
    RET 
 SOMAEIMPRESSAO ENDP
END MAIN