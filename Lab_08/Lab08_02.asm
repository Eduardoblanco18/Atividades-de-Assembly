TITLE IMPRIME binário
.MODEL SMALL
.DATA 
    MSG DB "O numero em binario: $"
.CODE 
 MAIN PROC
    ;libero acesso ao .DATA
    MOV AX, @DATA
    MOV DS, AX
    ;copio um número arbitrario em BX (alterando como desejar)
    MOV BX, 6
    ;coloco 16 no contador, referente ao número de bits
    MOV CX, 16
    ;imprimo a mensagem 1
    MOV AH, 9
    LEA DX, MSG
    INT 21H
    ;função de imprimir caractere em DL
    MOV AH, 2

VOLTA:
    ROL BX, 1; rotaciono BX para esquerda em uma casa
    JC IMP1 ;se carry flag == 1, então pula para IMP1

    MOV DL, '0' ; se n, coloco '0' em DL
    JMP IMP ;Pula para impressão
IMP1:;rotulo IMP1
    MOV DL, '1' ;coloco '1' em DL
IMP:
    INT 21H ;realizo a função
    LOOP VOLTA ;Loop em volta
    ;Devolve controle para sistema operacional
    MOV AH, 4CH 
    INT 21H
 MAIN ENDP
END MAIN