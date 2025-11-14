TITLE organiza matriz
.MODEL SMALL
STACK 100H
.DATA 
    N EQU 4
    MATRIZ DB N DUP( N DUP(?))
.CODE
 MAIN PROC
    ;inicializo DS
    MOV AX, @DATA
    MOV DS, AX
    ;chamo procedimento de digitar matriz
    CALL DIGITA
    ;chamo procedimento para organizar a matriz
    CALL ORGANIZA
    ;line feed para elhor vizualização
    MOV AH, 2
    MOV DL, 10
    INT 21H
    ;chamo procedimento para imprimir a matriz
    CALL IMPRIME
    ;finalizo o programa
    MOV AH, 4CH
    INT 21H
 MAIN ENDP

 DIGITA PROC
    ;procedimento de salvar a matriz do usuario
    ;ENTRADA: nenhuma
    ;SAIDA: matriz salva
    ;zero BX, inicializo função de copiar, e zero contador externo
    XOR BX, BX
    MOV AH, 1
    XOR DX, DX
    ;zero SI e inicializo contador interno
    DIGITA_COLUNA:
    XOR SI, SI
    MOV CX, N
    ;copio e jogo na posição da matriz equivalente
    DIGITA_LINHA:
    INT 21H
    AND AL, 0FH
    MOV MATRIZ[BX][SI], AL
    INC SI
    LOOP DIGITA_LINHA ;incremento SI e continuo

    ADD BX, N
    INC DX
    CMP DX, N
    JB DIGITA_COLUNA ;somo N em BX

    RET ;volto ao ponto de chamada
 DIGITA ENDP

 ORGANIZA PROC
    ;procedimento para organizar a matriz salva
    ;ENTRADA: matriz salva desorganizada
    ;SAIDA: Matriz organizada
    ;zero BX DX DI 
    XOR BX, BX
    XOR DX, DX
    XOR DI, DI
    MOV CX, N
    DEC CX
    inicializaDI:
    ADD DL, N
    LOOP inicializaDI ;coloco N * (N-1) em DL

    ORGANIZA_COLUNA: ;zero SI e inicializo DI com o outro lado. tbm incializo contador interno
    XOR SI, SI
    MOV CX, N
    MOV DI, N
    DEC DI

    ORGANIZA_LINHA: ;troco conteudo com as posições opostas
    MOV AL, MATRIZ[BX][SI]
    XCHG DI, SI
    XCHG BX, DX
    XCHG AL, MATRIZ[BX][SI]
    XCHG BX, DX
    XCHG DI, SI
    XCHG AL, MATRIZ[BX][SI]
    INC SI
    DEC DI
    LOOP ORGANIZA_LINHA ;incremento SI, decremento DI e repito

    ADD BX, N
    SUB DL, N
    CMP BX, DX
    JBE ORGANIZA_COLUNA ;somo N em BL e subtraio N em DL, até que passem uma da outra

    RET ;volto ao ponto de chamada
 ORGANIZA ENDP

 IMPRIME PROC
    ;procedimento de imprimir matriz salva
    ;ENTRADA: matriz salva 
    ;SAIDA: matriz impressa
    ;zero BX, inicializo a função de imprimir caractere, e zero contador externo
    XOR BX, BX
    MOV AH, 2
    XOR DX, DX
    ;zero SI e inicializo contador interno 
    IMPRIME_COLUNA:
    XOR SI, SI
    MOV CX, N

    IMPRIME_LINHA: ;jogo o conteudo em DL, transformo em caractere e imprimo com um espaço de diferença
    MOV DL, MATRIZ[BX][SI]
    OR DL, 30H
    INT 21H
    MOV DL, ' '
    INT 21H
    INC SI
    LOOP IMPRIME_LINHA ;incremento SI e repito

    MOV DL, 10 ;line feed para melhor vizualização
    INT 21H

    ADD BX, N
    INC DH
    CMP DH, N
    JB IMPRIME_COLUNA ;somo N em BX incremtno DH até ser igual a N, e repito

    RET ;retorno ao ponto de chamada 
 IMPRIME ENDP
END MAIN