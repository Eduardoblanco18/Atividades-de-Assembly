TITLE Calculadora de multiplicação
.MODEL SMALL
.DATA
    multiplicando DB "Digite o multiplicando: $"
    multiplicador DB "Digite o multiplicador: $"
    produto DB "Produto: $"
.CODE
 MAIN PROC
    ;Libero o acesso ao .DATA
    MOV AX, @DATA
    MOV DS, AX
    ;Imprimo a msg de Multiplicando
    MOV AH, 9
    LEA DX, multiplicando
    INT 21H
    ;Copio o caractere digitado
    MOV AH, 1
    INT 21H
    ;Transformo em número decimal e salvo em BL
    AND AL, 0FH
    MOV BL, AL
    ;Line feed para melhor vizualização
    MOV AH, 2
    MOV DL, 10
    INT 21H
    ;Imprimo a string de multiplicador
    MOV AH, 9
    LEA DX, multiplicador
    INT 21H
    ;Copio o caractere digitado
    MOV AH, 1
    INT 21H

    CMP AL, '0' ;compara o caractere digitado com zero
    JZ multiplicador0 ;se for zero pula para rotulo 
    
    AND AL, 0FH ;Transformo em número decimal
    SUB AL, 1 ;Subtraiu 1 para corrigir na hora da conta
    MOV CL, AL ;Salvo em CL

    ;Line feed para melhor vizualização
    MOV AH, 2
    MOV DL, 10
    INT 21H
    ;copio BL em DL
    MOV DL, BL

Mulitiplicacao:
    ADD BL, DL ;Somo DL em BL para simular a multiplicação
    LOOP Mulitiplicacao ;Subtraio de CL E repito o numero do multiplicador 
    ADD BL, '0' ;Transformo em Hexadecimal 
    ;Imprimo a msg do produto
    MOV AH,9
    LEA DX, produto
    INT 21H
    ;Imprimo o produto salvo em BL
    MOV AH, 2
    MOV DL, BL
    INT 21H

    JMP FIM ;pula para o rotulo fim
multiplicador0:
    ;line feed para melhor vizualização
    MOV AH, 2
    MOV DL, 10
    INT 21H
    ;imprimo msg produto
    MOV AH, 9
    LEA DX, produto
    INT 21H
    ;imprimo o produto, nesse caso 0 pq qualquer número multiplicado por 0 o produto eh 0
    MOV AH, 2
    MOV DL, '0'
    INT 21H
FIM:
    ;devolvo o controle pro Sistema operacional
    MOV AH, 4CH
    INT 21H
 MAIN ENDP
END MAIN