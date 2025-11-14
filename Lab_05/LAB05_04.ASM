TITLE imprime letras agrupadas
.MODEL SMALL
.CODE 
 MAIN PROC

    MOV CL, 4 ; inicia o contador com o número de repetções, nesse caso 4
    MOV DL, 'a' ;coloca 'a' em DL para iniciar o loop 

Grupo1: 

    MOV AH, 2 ;imprime o que está em DL
    INT 21H
    INC DL ;incrementa e vai pra próxima letra
    LOOP Grupo1 ; faz o loop até CX ser 0

    MOV AH, 2 ; imprime carriege return para ir pra próxima linha 
    MOV DL, 10
    INT 21H

    MOV CL, 4 ; inicia contador com o numero de repetições
    MOV DL, 'e'; movimenta 'e' em DL para a proxima linha 

Grupo2:

    MOV AH, 2 ; imprime o que está em DL
    INT 21H
    INC DL ; incrementa para ir pra próxima letra
    LOOP Grupo2 ; segundo loop 
    
    MOV AH, 2 ; carriege return
    MOV DL, 10
    INT 21H
    
    MOV CL, 4 ; inicia o contador com o numero de repetições
    MOV DL, 'i'; inicia DL com 'i'

Grupo3:

    MOV AH, 2 ; imprime o que está em DL
    INT 21H
    INC DL ;incrementa para ir para próxima letra
    LOOP Grupo3 ;terceiro loop

    MOV AH, 2 ; carriege return
    MOV DL, 10
    INT 21H

    MOV CL, 4 ; inicia o contdor com o numero de repetições
    MOV DL, 'm'; inicia DL com 'm'

Grupo4:

    MOV AH, 2 ;imprime o que está em DL
    INT 21H
    INC DL ;incrementa DL para ir pra próxima linha
    LOOP Grupo4 ; quarto loop

    MOV AH, 2 ; carriege return 
    MOV DL, 10
    INT 21H

    MOV CL, 4 ;inicia o contador com o numeros de repetições 
    MOV DL, 'q'; inicia DL com 'q'

Grupo5:

    MOV AH, 2 ;imprime o que está em DL
    INT 21H
    INC DL ;incrementa DL para ir para a proxima letra
    LOOP Grupo5 ; quinto loop 

    MOV AH, 2 ; carriege return
    MOV DL, 10
    INT 21H
    
    MOV CL, 4 ; inicia o contador com numeros de repetições
    MOV DL, 'u' ;inicia DL com 'u'

Grupo6:

    MOV AH, 2 ;imprime o que está em DL
    INT 21H
    INC DL ;incrementa DL para ir para a próxima letra
    LOOP Grupo6 ; sexto loop

    MOV AH, 2 ;carriege return
    MOV DL, 10
    INT 21H

    MOV CL, 2 ;inicia o contador com o numero de repetições nesse caso 2
    MOV DL, 'y' ; inicia DL com 'y'

Grupo7:

    MOV AH, 2 ;imprime o que está em DL
    INT 21H
    INC DL ;incrementa DL para ir pra proxima letra
    LOOP Grupo7

    MOV AH, 4Ch ; finaliza o programa
    INT 21H
 MAIN ENDP
END MAIN
