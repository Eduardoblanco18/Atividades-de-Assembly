TITLE Somador 
.MODEL SMALL
.DATA ; salvar as strings em .DATA
    MSG1 DB 'Digite um primeiro numero: $'
    MSG2 DB 'Digite um segundo numero: $'
    MSG3 DB 'A soma dos dois numeros eh: $'
.CODE 
 MAIN PROC
    
    MOV AX, @DATA ; Endereço de .DATA é passado para registrador AX
    MOV DS, AX ; e salvo em DS logo em seguida 

    MOV AH,9 ; função 9h para ler string 
    LEA DX, MSG1 ; endereço de MSG1 eh salvo no registrador DX
    INT 21h ; INT 21h para realizar a função 

    MOV AH, 1 ; função de copiar o caracter digitado, nesse caso um numeral 
    INT 21h ; realzar função

    MOV BL, AL ; salvo o numeral que foi copiado em AL e agr salvo em BL
    SUB BL,30H ; é necessaria tirar 30h do número salvo para conseguir realizar a operação de soma que desejamos  

    MOV AH, 2 ; função 2 para imprimir um caracter 
    MOV DL, 10; imprime o caracter 10 que, na tabela ASCII, representa o line feed 
    INT 21h ; realiza a função

    MOV AH, 9 ; função 9 para imprimir string 
    LEA DX, MSG2 ; DX recebe o endereço de MSG2
    INT 21h ; realiza a função 

    MOV AH, 1 ; função 1h para copiar outro numeral digitado
    INT 21h ; realiza a função 
    SUB AL,30H ; e logo em seguida tira 30h para conseguir somar!
    ADD BL, AL ; função de soma em que o registrador BL recebe o resultado 

    MOV AH, 2 ; função 2h para exibir um caracter 
    MOV DL, 10 ; caracter 10 que representa o line feed 
    INT 21h ; realiza a função 

    MOV AH, 9 ; função 9 para imprimir strings
    LEA DX, MSG3 ; DX recebe endereço de MSG3
    INT 21h ; realzia a função 

    MOV AH, 2 ; função 2h para imprimir o caracter 
    MOV DL, BL ; passo o número salvo em BL para DL para que a função imprima o número somado
    ADD DL,30H ; Somar 30h para voltar o código Hexadecimal do número somado, por isso o limite ser 9, da soma
    INT 21h ; realiza a função 2h

    MOV AH, 4Ch ; função de finalização do programa 
    INT 21h ; finaliza o programa
 MAIN ENDP
END MAIN