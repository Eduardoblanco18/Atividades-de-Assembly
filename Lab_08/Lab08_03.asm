TITLE Copia um número hexadecimal
.MODEL SMALL
.DATA
    ENTRADA DB "Digite um digito: $"
    FINALIZAÇÃO DB "O programa foi encerrado. $"
.CODE
 MAIN PROC 
    ;Libero acesso ao .DATA
    MOV AX, @DATA
    MOV DS, AX
    ;Zero BX e CX
    XOR BX,BX
    XOR CX,CX
    ;Imprimo msg de entrada
    MOV AH, 9
    LEA DX, ENTRADA
    INT 21H
    ;Função de copiar caractere digitado
    MOV AH, 1

DIGITA:
    INT 21H ;realizo a função

    CMP AL, 13 ;Compara com carriege return; para ver final do Número
    JE FIM ;Se for igual, pula para rotulo FIM

    ROL BX, 4; rotaciona BX 4 casas pro lado 

    CMP AL, 'A';Compara a letra A maiucula
    JAE LETRA; se for maior ou igual, pula para rotulo LETRA

    AND AL, 0FH ; transformo o caractere em número
    OR BL, AL ; insiro em BL
    JMP INCREMENTA ; pulo para o rotulo DIGITA

    LETRA:
    SUB AL, 55 ;Subtraio 55 para trnasformar a letra em número Hexadecimal
    OR BL, AL ;insiro em BL

    INCREMENTA:
    ;Incremento CX e comparo com 4(máximo de números hexadecimais que consigo salvar no resgistrador) e se for igual pulo para o fim do programa
    INC CX
    CMP CX, 4
    JE FIM

    JMP DIGITA ; pulo para o rotulo DIGITA

FIM: 
    ;imprimo line feed para melhor vizualiação
    MOV AH, 2
    MOV DL, 10
    INT 21H
    ;imprimo mensagem de finalização
    MOV AH, 9
    LEA DX, FINALIZAÇÃO
    INT 21H
    ;devolvo controle para o Sistema operacional
    MOV AH, 4CH
    INT 21H
 MAIN ENDP
END MAIN