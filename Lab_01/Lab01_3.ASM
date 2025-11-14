TITLE Mostrar Caractér Digitado
.MODEL SMALL
.DATA ;Salvar as mensagens em .DATA. para utilizar elas depois 
MSG1 DB 'Digite um caracter: $' ;Não equecer do '$' para terminar a string
MSG2 DB 'O caracter digitado foi: $'
.CODE
 MAIN PROC
   
    MOV AX, @DATA; Dá acesso ao .DATA e depois salva ele em DS
    MOV DS,AX

    MOV AH,9 ;Função 9, exibir string no terminal.
    LEA DX, MSG1 ;O endereço de MSG1 no espaço de memoria DX 
    INT 21h

    MOV AH,1 ;Função para copiar o caracter digitado no teclado (salva em AL em hexadecimal[ver tabela ASCII caso dúvidas])
    INT 21h

    MOV BL,AL ;Salva o caracter digitado em BL, para ser usado depois

    MOV AH,2 ;Função de exibir caracter para mover para linha de baixo
    MOV DL, 10 ;O  10, na tabela ASCII, sigicnifica line feed (desce para linha de baixo, mas na mesma posição)
    INT 21h

    MOV AH,2 ;Função de exibir caracter para mover o cursor para esquerda 
    MOV DL, 13 ;O 13, na tabela ASCII, significa 'carriege return' (faz o cursor ir para esquerda)
    INT 21h

    MOV AH,9 ;função 9, exibir string no terminal
    LEA DX, MSG2 ;O endereço de MSG2 no espaço de memoria DX
    INT 21h

    MOV AH,2 ;Função 2, exibir um caracter no terminal
    MOV DL, BL ;A função 2 exibirá o caracter salvo em BL(aquele digitado) 
    INT 21h ;Importante dizer que para a função funcionar eh necessário que o que será exibido esteja em DL

    MOV AH, 4Ch ;Função de finalização do programa
    INT 21h
 
 MAIN ENDP
END MAIN