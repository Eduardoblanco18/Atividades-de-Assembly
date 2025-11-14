TITLE Mensagem
.MODEL SMALL
.DATA ;sempre guardar strings no .DATA, qualquer tipo de mensagem 
MSG1 DB 'Mensagem 1$'  ;N esquecer de colocar o '$' para mostrar onde parar de ler  
MSG2 DB 10,13, 'Mensagem 2$'; '10,13' serve para colocar em outra linha (o 'Enter' do Assembly)
.CODE
 MAIN PROC
    ;liberar acesso ao .DATA
    MOV AX, @DATA ;AX é um registrador do processador, dividido em AH(bits da esquerda, mais significativos) e AL(bits da direita, menos significativos). muito utilizada para chamada de funções 
    MOV DS, AX
    ;Agora ele vai ler MSG1
    MOV AH,9 ;um exemplo de chamada de função (o 9 é a função de exibir string)
    LEA DX,MSG1 ;DX (o registrador inteiro) recebe o endereço de MSG1
    INT 21h; INT 21h é essencial para realização de qualquer função. Nesse caso, caso eu retire esse INT 21h apenas a MSG2 será exibida no terminal
    ;Agora, a MSG2
    MOV AH,9 ;essa repetição, nesse caso, é desnecessário, porém n levar como regra. há sim a necessidade de repetir essa chamada de função
    LEA DX,MSG2 ;Agr ele recebe o endereço de MSG2
    INT 21h
    ;FINALIZAÇÃO DO PROGRAMA
    MOV AH, 4Ch ;função para finalizar o programa
    INT 21h
 MAIN ENDP
END MAIN