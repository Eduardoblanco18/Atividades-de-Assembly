TITLE Par ou impar
.MODEL SMALL
.DATA
    ENTRADA DB 10,13,"Digite um numero: $"
    PAR DB 10,13,"O numero eh par!$"
    IMPAR DB 10, 13,"O numero eh impar!$"
.CODE
 MAIN PROC 
    ;Libero o Acesso ao .DATA
    MOV AX, @DATA
    MOV DS, AX
    ;Coloco o número de reetições do código
    MOV CL, 2

REPETICAO:;rotulo para repetir 
    ;Imprimo a msg de entrada
    MOV AH, 9
    LEA DX, ENTRADA
    INT 21H
    ;copio o caractere digitado
    MOV AH, 1
    INT 21H
    ;transformo em número e faço um AND com 1, se o resultado for 0 (ZF == 1) o número eh par, se n (ZF == 0) o número eh impar
    AND AL, 0FH
    AND AL, 1
    JZ NUMPAR ;Caso ZF == 1 pula pra rotulo NUMPAR (número par)
    ;imprimo que o número eh impar
    MOV AH, 9
    LEA DX, IMPAR
    INT 21H
    JMP FIM ;pulo para o rotulo fim

NUMPAR:
    ;imprimo que o número eh par
    MOV AH, 9
    LEA DX, PAR
    INT 21H

FIM: ;fim pula para o Loop para fazer o código duas vezes, assim pegando dois números, como foi pedido pelo enunciado
    LOOP REPETICAO
    ;devolvo o controle para o sistema operacional
    MOV AH, 4CH
    INT 21H

 MAIN ENDP
END MAIN