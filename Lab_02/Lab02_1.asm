TITLE Transformador em letra minuscula em maiuscula 
.MODEL SMALL
.DATA ; .DATA para salvar as strings usadas no programa
    MSG1 DB 'Digite uma letra minuscula: $'
    MSG2 DB 'A letra maiuscula correspondente eh: $'
.CODE 
 MAIN PROC

    MOV AX, @DATA ; AX recebe o endereço de data
    MOV DS, AX ; e logo em seguida salvo no registrador DS

    MOV AH, 9 ; aqui utilizo a função 9h para exibir a string
    LEA DX, MSG1 ; DX recebe o endereço de MSG1
    INT 21h ; e aqui a string eh exibida no terminal

    MOV AH, 1 ; utilizo a função 1h para copiar o caracter digitado 
    INT 21h 

    MOV BL, AL ; aqui o caracter digitado eh salvo em BL. (foi passado de AL para BL)

    SUB BL, 20h; decremento 20h do caracter salvo em BL, assim tornando-o em maiusculo

    MOV AH, 2 ; função 2 de exibir um carácter
    MOV DL, 10; caracter 10h representa o line feed (tabela ASCII)
    INT 21h

    MOV AH, 2 ; função 2 de exibir um carácter
    MOV DL, 13 ; caracter 13h representa o carriege return (tabela ASCII)
    INT 21h

    MOV AH, 9 ; função 9h de exibir uma string
    LEA DX, MSG2 ; DX, agr, recebe o endereço de MSG2 
    INT 21h ; e eh exibido na tela novamente 

    MOV AH, 2 ; função 2h de exibir  um caracter 
    MOV DL, BL; DL recebe o caracter digitado decrementado 20h, ou seja, maiusculo 
    INT 21h; exibe na tela 

    MOV AH, 4Ch ; finaliza o programa
    INT 21h
 MAIN ENDP
END MAIN