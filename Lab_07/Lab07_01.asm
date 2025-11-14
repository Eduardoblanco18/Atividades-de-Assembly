TITLE CALCULADORA DE DIVISÃO
.MODEL SMALL
.DATA
    dividendo DB "Digite o dividendo: $"
    divisor DB "Digite o divisor: $"
    quociente DB "Quociente: $"
    resto DB "Resto: $"
.CODE 
 MAIN PROC 
    ;libero o acesso ao .DATA
    MOV AX, @DATA
    MOV DS, AX
    ;zero o registrador CX
    XOR CX, CX
    ;Função para imprimir string, imprimo a msg de dividendo
    MOV AH, 9
    LEA DX, dividendo
    INT 21H
    ;copio o caracter digitado
    MOV AH, 1
    INT 21H
    ;Transformo em número com operação lógica AND e salvo em BL
    AND AL, 0FH
    MOV BL, AL

DivisorZero: ;Rotulo que garante que o divisor n será 0
    ;Imprimo line feed, para melhor vizualição do usuário
    MOV AH, 2
    MOV DL, 10
    INT 21H
    ;função de imprimir string, imprimo a msg de divisor
    MOV AH, 9
    LEA DX, divisor
    INT 21H
    ;função de copiar caracter digitado
    MOV AH, 1
    INT 21H
    ;comparo AL com 0, se for zero, reinicia (proibida divisão por zero)
    CMP AL, '0'
    JE DivisorZero ;pula, caso ZF == 1, para o rotulo 
    ;transformo AL em número
    AND AL, 0FH
Divisao:
    SUB BL, AL ;Subtraio AL de Bl
    INC CL ;Aumento o contador do quociente
    CMP BL, AL ;Compara BL, AL
    JAE Divisao ;Se for maio o igual, repete a subtração
    ;transformo os valores em hexadecimais novamente
    ADD CL, '0'
    ADD BL, '0'
    ;Line feed para melhor vizualização
    MOV AH, 2
    MOV DL, 10
    INT 21H
    ;Imprimo msg do quociente
    MOV AH, 9
    LEA DX, quociente
    INT 21H
    ;Impimo o quociente, salvo em CL
    MOV AH, 2
    MOV DL, CL
    INT 21H
    ;line feed para melhor vizualização
    MOV DL, 10
    INT 21H
    ;imprimo a msg de resto
    MOV AH, 9
    LEA DX, resto
    INT 21H
    ;Imprimo o resto, salvo em BL
    MOV AH, 2
    MOV DL, BL
    INT 21H 
    ;Devolvo o controle para o sistema operacional
    MOV AH, 4CH
    INT 21H
 MAIN ENDP
END MAIN
