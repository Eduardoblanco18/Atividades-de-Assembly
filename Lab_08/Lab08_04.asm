TITLE Imprime número hexadecimal
.MODEL SMALL
.DATA 
    MSG DB "Seu numero: $"
.CODE 
MAIN PROC 
    ;libero acesso ao .DATA
    MOV AX, @DATA
    MOV DS, AX

    MOV BX, 0F8H ;valor de BX arbitrario 
    MOV CX, 4 ; Coloco contador em 4
    ;imprimo a MSG
    MOV AH, 9
    LEA DX, MSG
    INT 21H
    ;função de imprimir carcatere
    MOV AH, 2

Volta:
    ROL BX, 4 ;rotaciono BX em 4 casas decimais
    
    MOV DX, BX ;copio BX em DX

    AND DX, 000FH ;zero 12 bits n desejados

    CMP DX, 10 ;compara dx com 10
    JAE LETRA ;se maior ou igual, pula para LETRA

    ADD DX, 30H ;se n, adiciono 30h, para transformar em caractere
    JMP IMP ;pulo para imprimir

    LETRA:
    ADD DX, 55 ;se for maior qwue 10, adiiono 55 para transformar em letra
    JMP IMP ;pulo para impressão

    IMP:
    INT 21H ;imprimo
    LOOP Volta ;subtraio CX e volto até CX == 0
    ;devolvo o controle para o sistema operacional
    MOV AH, 4CH
    INT 21H

 MAIN ENDP
END MAIN