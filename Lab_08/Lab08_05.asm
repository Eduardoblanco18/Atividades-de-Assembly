TITLE Copia e imprime (binário ou hexadecimal)
.MODEL SMALL
.DATA
    ESCOLHAentrada DB 'ESCOLHA A FORMA DE ENTRADA!',10,13,'1-Binario',10,13,'2-Hexadecimal',10,13,'$'
    ESCOLHAsaida DB 'AGORA, ESCOLHA A SAIDA!',10,13,'1-Binario',10,13,'2-Hexadecimal',10,13,'$'
    SEUNUM DB 'Seu numero eh: $'
.CODE 
 MAIN PROC 
    ;libero acesso ao .DATA
    MOV AX, @DATA
    MOV DS, AX

    XOR CX, CX
    ;imprimo mensagem de escolher o tipo de entrada
    MOV AH, 9
    LEA DX, ESCOLHAentrada
    INT 21H
    ;copio a escolha do usuário
    MOV AH, 1
    INT 21H
    ;transformo em número
    AND AL, 0FH
    ;compara com as opções, nesse caso, 2 é hexadecimal
    CMP AL, 2
    JE Hexadecimal ; se for igual a 2, pula para rotulo Hexadecimal

    CALL COPIABINARIO ;se n, chamada de preoceimento COPIABINARIO, para copiar o número em binário que o usurario vai escrever
    JMP SAIDA ;pula para saida depois do procedimento

    Hexadecimal:

    CALL COPIAHEXADECIMAL ;se a escolha do usuario foi 2, então chamada de procedimento para copiar o número em hexadecimal que o usuario vai escrever

    SAIDA: 
    ;Imprimo line feed para melhor vizualização no terminal
    MOV AH, 2
    MOV DL, 10
    INT 21H
    ;imprimo a mensagem de escolher o tipo de saída
    MOV AH, 9
    LEA DX, ESCOLHAsaida
    INT 21H
    ;copio a escolha dele
    MOV AH, 1
    INT 21H
    ;transformo em número
    AND AL, 0FH

    CMP AL, 1;compara com as opções, nesse caso se for 1 é binário
    JE Binario ;se igual a 1, pula para Binario

    CALL SAIDAHEXADECIMAL ;se n, chamada de procedimento para imprimir o número digitado em Hexadecimal
    JMP FIM ;pula para o fim do programa

    Binario:
    CALL SAIDABINARIO ; se a escolha foi 1, então chamada de procedimento para imprimir o número digitado em Binário

    FIM:
    ;devolvo o controle para o sistema operacional
    MOV AH, 4CH
    INT 21H
 MAIN ENDP

 COPIABINARIO PROC
    ;PROCEDIOMENTO DE COPIAR UMA STRING DE NÚMERO BINÁRIOS
    ;SEM ENTRADA
    ;SAÍDA STRING DE 0 E 1 EM BX
    ;imprimo line feed para ,elhor vizualização
    MOV AH,2
    MOV DL, 10
    INT 21H
    
    MOV AH, 1 ; função de copiar caractere digitado

DIGITABI: 
    INT 21H ; realizo a função

    CMP AL, 13 ;comparo com carriege return
    JE SAIbi ; se for igual saio do loop

    SHL BX, 1 ; movo BX uma casa para esquerda

    AND AL, 0FH ;transformo caractere digitado em número

    OR BL, AL ;faço um OR para somar em BL

    INC CX ;incremento CX e comparo com 16 (limite de digitos binários) se for igual sai do procedimento
    CMP CX, 16
    JE SAIbi
    
    JMP DIGITABI ;refaço o loop
    
    SAIbi:
    RET ;retorn ao main
 COPIABINARIO ENDP
    
 COPIAHEXADECIMAL PROC 
    ;Procedimento de copiar caractere digitado
    ;entrada: nenhuma
    ;saida: hexadecimal em BX
    ;imprimo line feed para melhor vizualiação
    MOV AH,2
    MOV DL, 10
    INT 21H
    ;função de copiar 
    MOV AH, 1

    DIGITAHEX:
    INT 21H ;realizo a função

    CMP AL, 13 ;Compara com carriege return; para ver final do Número
    JE SAIhex ;Se for igual, pula para rotulo FIM

    ROL BX, 4; rotaciona BX 4 casas pro lado 

    CMP AL, 'A';Compara a letra A maiucula
    JAE COPIALETRA; se for maior ou igual, pula para rotulo LETRA

    AND AL, 0FH ; transformo o caractere em número
    OR BL, AL ; insiro em BL
    JMP INCREMENTA ; pulo para o rotulo DIGITA

    COPIALETRA:
    SUB AL, 55 ;Subtraio 55 para trnasformar a letra em número Hexadecimal
    OR BL, AL ;insiro em BL

   INCREMENTA:
    INC CX ;incremento CX e comparo com 4 (máximo de digitos hexadecimais), se for igual saí do procedimento
    CMP CX, 4
    JE SAIhex


    JMP DIGITAHEX ; pulo para o rotulo DIGITA

    SAIhex:
    RET 
 COPIAHEXADECIMAL ENDP

 SAIDABINARIO PROC
    ;PROCEDIMENTO DE IMPRESSÃO DE NÚMERO BINÁRIO
    ;ENTRADA VALOR SALVO EM BX
    ;SAIDA NO TERMINAL
    ;imprimo linefeed para melhor vizualização
    MOV AH, 2
    MOV DL, 10
    INT 21H
    ;imprimo mensagem apresentando seu número
    MOV AH, 9
    LEA DX, SEUNUM
    INT 21H
    ;coloco 16 no contador (16 bits)
    MOV CX, 16
    ;função de imprimir caractere
    MOV AH, 2
    
    IMPRIMEBI:
    ROL BX, 1; rotaciono BX para esquerda em uma casa
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

 SAIDAHEXADECIMAL PROC
    ;PROCEDIMENTO DE IMPRESSÃO DE NÚMERO HEXADECIMAL
    ;ENTRADA: NÚMERO SALVO EM BX
    ;SAIDA: IMPRESSO NO TERMINAL
    ;imprimo line feed para melhor vizualização
    MOV AH, 2
    MOV DL, 10
    INT 21H
    ;imprimo mensagem apresentando seu número
    MOV AH, 9
    LEA DX, SEUNUM
    INT 21H
    ;coloco 4 no contador (4 números hexadecimais = 16bits)
    MOV CX, 4
    ;função de imprimir
    MOV AH, 2

    Volta:
    ROL BX, 4 ;rotaciono BX em 4 casas decimais
    
    MOV DX, BX ;copio BX em DX

    AND DX, 000FH ;zero 12 bits n desejados

    CMP DX, 10 ;compara dx com 10
    JAE IMPRIMELETRA ;se maior ou igual, pula para LETRA

    ADD DX, 30H ;se n, adiciono 30h, para transformar em caractere
    JMP IMPHEX ;pulo para imprimir

    IMPRIMELETRA:
    ADD DX, 55 ;se for maior qwue 10, adiiono 55 para transformar em letra

    IMPHEX:
    INT 21H ;imprimo
    LOOP Volta ;subtraio CX e volto até CX == 0

    RET
 SAIDAHEXADECIMAL ENDP

END MAIN