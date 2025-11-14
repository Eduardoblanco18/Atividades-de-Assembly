TITLE DEFINE MAIO E MENOR
.MODEL SMALL
.DATA 
    ENTRADA DB 10, 13, "Entre com um numero: $"
    MAIOR DB " Eh maior", 10, 13, '$'
    MENOR DB " Eh menor", 10, 13, '$'
.CODE 
 MAIN PROC
    ;Libero o acesso
    MOV AX, @DATA
    MOV DS,AX
    ;Imprimi a mensagem de entrada
    MOV AH, 9
    LEA DX, ENTRADA
    INT 21H
    ;Copia o caractere digitado
    MOV AH, 1
    INT 21H
    ;Salva o caractere em BL
    MOV BL, AL
    ;imprime novamente a mensagem de entrada
    MOV AH, 9
    LEA DX, ENTRADA
    INT 21H
    ;copia o caractere digitado
    MOV AH, 1
    INT 21H
    ;Compara AL com BL
    CMP AL, BL 
    JG ALMAIOR ;Se Al for maior joga para esse rotulo
    ;Se AL n for maior, troco AL e BL
    XCHG AL, BL
    ;Imprimo Oq está em AL
    MOV AH, 2
    MOV DL, AL
    INT 21H
    ;Imprimo msg de maior
    MOV AH, 9
    LEA DX, MAIOR
    INT 21H
    ;Imprimo oq está em BL
    MOV AH, 2
    MOV DL, BL
    INT 21H
    ;IMprimo msg menor
    MOV AH, 9
    LEA DX, MENOR
    INT 21H
    
    JMP FIM ;pulo pro rotulo fim

ALMAIOR:
    ;imprimo oq está em AL
    MOV AH, 2
    MOV DL, AL
    INT 21H
    ;imprimo a msg maior 
    MOV AH, 9
    LEA DX, MAIOR
    INT 21H
    ;imprimo o caractere que está em BL
    MOV AH, 2
    MOV DL, BL
    INT 21H
    ;imprime a msg menor
    MOV AH, 9
    LEA DX, MENOR
    INT 21H
FIM:
    ;Devolve o controle para o Sistema operacional
    MOV AH, 4CH
    INT 21H

 MAIN ENDP
END MAIN