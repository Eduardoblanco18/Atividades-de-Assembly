TITLE exemplo 
.MODEL SMALL
.DATA
    MSG DB 'Ola bem vindo', 10, 13, '$'
.CODE 
 MAIN PROC
    ;inicializa DS com o endereço de @DATA
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH, 9 ;Função de imprimir a string
    MOV DX, OFFSET MSG ; DX recebe o endereço inicial de MSG 
    INT 21h ; realiza a função 

    MOV AH, 4Ch ; finaliza a função
    INT 21h ; retorna ao sistema operacional 
 MAIN ENDP
END MAIN