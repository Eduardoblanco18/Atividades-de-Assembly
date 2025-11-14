TITLE troca base do número
.MODEL SMALL
.STACK 100H
.DATA
    escolhaentrada DB "QUAL VAI SER A ENTRADA: ", 10, 13, '1 - BINARIO', 10, 13, '2 - HEXADECIMAL', 10, 13, '3 - DECIMAL',10, 13, '$'
    escolhasaida   DB "QUAL VAI SER A SAIDA: ", 10, 13, '1 - BINARIO', 10, 13, '2 - HEXADECIMAL', 10, 13, '3 - DECIMAL',10, 13, '$' 
    digitenumero   DB 10, 13, "DIGITE O NUMERO: $"
    imprimenumero  DB 10,13, "AQUI ESTA O SEU NUMERO: $"
.CODE
 MAIN PROC
    ;inicializo DS
    MOV AX, @DATA
    MOV DS, AX
    ; Imprimo mensagem para usuario escolher entrada
    MOV AH, 9
    LEA DX, escolhaentrada
    INT 21H
    ;pego a escolha do usuario 
    MOV AH, 1
    INT 21H
    ;transformo em número e comparo com opção de decimal
    AND AL, 0FH
    CMP AL, 3
    JE numerodecimal
    ;se ele n quiser decimal, vejo que se ele quer hexadecimal
    CMP AL, 2
    JE numerohexadecimal
    ; se nenhum dos dois, coloco os valores de entrada para o procedimento de escrita binário
    MOV DX, 16
    MOV CX, 1
    CALL digitabiHEX
    JMP escolheimpressao
    ;coloco os valores de entrada para o procedimento de escrita hexadecimal
    numerohexadecimal:
    MOV DX, 4
    MOV CX, 4
    CALL digitabiHEX
    JMP escolheimpressao
    ;chamo a função para escrever em decimal
    numerodecimal:
    CALL digitadecimal
    ;line feed para melhor vizauliação 
    escolheimpressao:
    MOV AH, 2
    MOV DL, 10
    INT 21H
    ;imprimo mensagem de escolha de saída 
    MOV AH, 9
    LEA DX, escolhasaida
    INT 21H
    ;salvo a escolha do usario 
    MOV AH, 1
    INT 21H
    ;transformo em número e vejo se ele quer saida em decimal
    AND AL, 0FH
    CMP AL, 3
    JE impdecimal
    ;se n, vejo se quer em Hexadecimal 
    CMP AL, 2
    JE imphexadecimal
    ; se ele quiser em binario, coloco os valores de entrada para o procedimento de saída bi
    MOV DH, 16
    MOV CX, 1
    CALL imprimebi
    JMP fim
    ;se ele quiser hexadecimal, coloco os valores para o procedimento de saida hex
    imphexadecimal:
    MOV DH, 4
    MOV CX, 4
    CALL imprimeHEX
    JMP fim
    ;se ele quiser decimal, chamo procedimento de decimal
    impdecimal:
    CALL imprimedecimal

    fim:
    ;finalizo o programa
    MOV AH, 4CH
    INT 21H
 MAIN ENDP

 digitabiHEX PROC
    ;O USUARIO DIGTA UM NÚMERO NA BASE ESCOLHIDA
    ;ENTRADA: O MÁXIMO DE DIGITOS EM DX E O VALOR NO DESLOCAMENTE EM CX
    ;SAIDA: NÚMERO SALVO EM BX
    PUSH CX ;salvo os valores de CX e DX
    PUSH DX
    ;peço para ele escrever o número
    MOV AH, 9
    LEA DX, digitenumero
    INT 21H

    POP DX  ;recupero DX e salvo novamente
    PUSH DX

    MOV AH, 1
    
    escrevebiHEX: ;se ele escrever um número hexa, maior que A pula para rotulo escreveu letra
    INT 21H
    CMP AL, 13
    JE paradeler
    SHL BX, CL
    CMP AL, 'A'
    JAE digitouletra
    AND AL, 0FH ;se n foi maior que A então transformo em número 
    JMP decrementaDX
    
    digitouletra:
    SUB AL, 55

    decrementaDX:;salvo em BX e qunado reinicio o loop faço BX rolar a quantidade em CL para o lado
    OR BL, AL
    DEC DX
    JNZ escrevebiHEX

    paradeler:
    POP DX
    POP CX
    RET ;retorno ao ponto de chamada
 digitabiHEX ENDP

 imprimeHEX PROC
    ;IMPRIME  NÚMERO QUE O USURAIO DIGITOU NA BASE ESCOLHIDA
    ;ENTRADA: QUANTIDADE DE MÁXIMA DE DIGITOS EM DH E DESLOCAMENTO EM CX E NÚMERO EM BX
    ;SAIDA: VALOR IMPRESSO NA TELA
    PUSH BX ;salvo BX, CX e DX
    PUSH CX
    PUSH DX

    MOV AH, 9 ;imprimo a mensagem de saida
    LEA DX, imprimenumero
    INT 21H
    POP DX ;recupero DX e salvo de novo
    PUSH DX

    XOR DL, DL ;zero DL e inicializo função de escrever caractere
    MOV AH, 2
    impH:
    ROL BX, CL ;rotaciono BX na qunatidade de casas salvo em CL
    MOV AL, BL
    AND AL, 0FH ; pego os últimos 4 bits menos significativos 

    CMP AL, 0AH ;vejo se eh maior que 10
    JAE imprimeletra

    OR AL, 30H ;se transformo em caractere número
    MOV DL, AL
    JMP decrementaDH

    imprimeletra:
    ADD AL, 55 ; se sim, transformo em caractere letra
    MOV DL, AL

    decrementaDH:
    INT 21H ;imprimo decremento DH e repito
    DEC DH
    JNZ impH

    POP DX
    POP CX
    POP BX
    RET ;volto a ponto de chamada
 imprimeHEX ENDP

 imprimebi PROC
    ;IMPRIME  NÚMERO QUE O USURAIO DIGITOU NA BASE ESCOLHIDA
    ;ENTRADA: QUANTIDADE DE MÁXIMA DE DIGITOS EM DH E DESLOCAMENTO EM CX E NÚMERO EM BX
    ;SAIDA: VALOR IMPRESSO NA TELA
    PUSH BX ;salvo BX CX e DX
    PUSH CX
    PUSH DX

    MOV AH, 9 ;imprimo mensage de saída 
    LEA DX, imprimenumero
    INT 21H
    POP DX ;recupero DX e salvo novamente
    PUSH DX

    MOV AH, 2 ;inicializo função de imprimir caractere
    impB:
    ROL BX, CL ;rotaciono BX na qunaitdade de casas salva em CL
    MOV AL, BL
    AND AL, 1 ;salvo o bit menos significativo

    OR AL, 30H ;transformo em caractere númerico
    MOV DL, AL

    INT 21H ;imprimo e decremento contador
    DEC DH
    JNZ impB

    POP DX
    POP CX
    POP BX
    RET ;retorno ao ponto de chamada
 imprimebi ENDP

 digitadecimal PROC
    ;O USUARIO ESCREVE UM NÚMERO NA BASE 10
    ;ENTRADA: NENHUMA
    ;SAIDA: NÚMERO SALVO EM BX

    MOV AH, 9 ;escrevo mensagem de entrada 
    LEA DX, digitenumero
    INT 21H

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
    int 21H ;se positivo, copio outro número 

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
    RET ;se n, retorno ao ponto de chamada
 digitadecimal ENDP

 imprimedecimal PROC
    ;IMPRIME O NÚMERO EM DECIMAL
    ;ENTRADA: NÚMERO SALVO EM BX
    ;SAIDA: NÚMERO IMPRESSO NA TELA EM BASE 10
    PUSH BX ;salvo o número

    MOV AH, 9 ;imprimo mensagem de saída
    LEA DX, imprimenumero
    INT 21H

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