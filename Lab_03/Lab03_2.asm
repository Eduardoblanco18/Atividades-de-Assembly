TITLE Fala se eh numer ou n 
.MODEL SMALL 
.DATA
    ;guarda as strings do programa em .DATA
    MSG1 DB 10, 13,"Digite ESC para finalizar o programa$" 
    MSG2 DB 10, 13,"Digite um caractere: $"
    MSGNUM DB 10, 13,"O caracter digitado eh um numero.$"
    MSGLETRA DB 10, 13,"O caracter digitado eh uma letra.$"
    MSGDESCONHECIDO DB 10, 13,"O caracter digitado eh um caractere desconhecido.$"
    MSGFINALIZACAO DB 10,13, "O programa foi finalizado.$"
.CODE
 MAIN PROC
    ;guarda o .DATA em DS
    MOV AX, @DATA
    MOV DS, AX

;rotulo para reniciar o programa
INICIO:
    ; escreve a primeira mensagem 
    MOV AH, 9
    LEA DX, MSG1
    INT 21h
    ;escreve a segunda mensagem 
    MOV AH, 9
    LEA DX, MSG2
    INT 21h
    ; copia o caracter digitado 
    MOV AH, 1
    INT 21h
    ; salva em BL
    MOV BL, AL

    CMP BL, 27 ; comparando com ESC
    JE FIM ; se for igual (BL - 'ESC'= 0) então pula pra rotulo FIM

    CMP BL, 48 ; COMPARANDO COM O 0
    JB DESCONHECIDO ; Pula apenas se for menor que 0. eh um carcter desconhecido 
    CMP BL, 57 ; COMPARANDO COM O 9
    JA TESTELETRAMAIUSCULA ; Pula apenas se for maior que 9, pode ser ou letra (minuscula ou maiscula0 ou caracter desconhecido 

    JMP NUMERO ; caso n seja nenhum dos dois, pula pra rotulo NUMERO

;rotulo para testar se eh uma letra maiuscula 
TESTELETRAMAIUSCULA:
    CMP BL, 65 ; comparando com 'A' maiusculo
    JB DESCONHECIDO ; pula apenas se foi menor, apenas caracteres desconhecidos 

    CMP BL, 90 ; comparando com 'Z' maiusculo
    JA TESTELETRAMINUSCULA ; pula apenas se for maior, pode ser ou uma letra minuscula ou caracter desconhecido 

    JMP LETRA ; caso nenhum dos dois, pula pra rotulo LETRA

;rotulo para testar se eh uma letra minuscula
TESTELETRAMINUSCULA:
    CMP BL, 97 ; comparando com 'a' minusculo
    JB DESCONHECIDO ; pula apenas se for menor, eh um caracter desconhecido 

    CMP BL, 122 ; comparando com 'z' minusculo
    JA DESCONHECIDO ; pula apenas se for maior, eh um caracter desconhecido 

    JMP LETRA ; se n for nenhum dos dois, pula pra rotulo LETRA

;rotulo pra caso for numero
NUMERO:
    ; se o programa pulou pra cá, o caracter eh u número. função 9 pra falar isso
    MOV AH, 9
    LEA DX, MSGNUM
    INT 21h
    JMP INICIO ; pula pro rotulo inicio pra 'reiniciar' o programa

;rotulo para caso for um caracter desconhecido
DESCONHECIDO:
    ; se o programa pulou pra cá, o caracter eh desconhecdo. função 9 pra falar isso
    MOV AH, 9
    LEA DX, MSGDESCONHECIDO
    INT 21h
    JMP INICIO ; pula pro rotulo inicio pra 'reiniciar' o programa

;rotulo para caso for letra
LETRA: 
    ; se o programa pulou pra cá, o caracter eh uma letra. função 9 pra falar isso
    MOV AH, 9
    LEA DX, MSGLETRA
    INT 21h
    JMP INICIO ; pula pro rotulo inicio pra 'reiniciar' o programa

;rotulo para finalizar o programa
FIM:
    ; função 9 pra falar que o programa finalizou
    MOV AH, 9
    LEA DX, MSGFINALIZACAO
    INT 21h
    ;finalização do programa
    MOV AH, 4Ch
    INT 21h
 MAIN ENDP
END MAIN
