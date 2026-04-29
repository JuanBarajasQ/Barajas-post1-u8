; post1a.asm - REP MOVSB: copia de cadena
; Compilar: nasm -f bin post1a.asm -o post1a.com

ORG 100h

section .data
 origen db "HOLA, MUNDO!",0
 destino db 13 dup(0) , "$"
 msgCop db "Copiado: $"
 crlf db 0Dh,0Ah,"$"

section .text

start:

; Copia optimizada: MOVSW para el grueso + MOVSB para byte impar
 mov ax, ds
 mov es, ax
 mov si, origen
 mov di, destino
 mov cx, 13 ; longitud total
 cld
 mov ax, cx
 shr cx, 1 ; CX = 13 / 2 = 6 words
 rep movsw ; copiar 6 words (12 bytes)
 and ax, 1 ; ¿habia byte impar? (13 AND 1 = 1)
 jz .fin
 movsb ; copiar el byte sobrante (posicion 13)

.fin:
 mov ah, 09h
 mov dx, msgCop
 int 21h
 mov dx, destino
 int 21h
 mov dx, crlf
 int 21h

 mov ah, 4Ch
 xor al, al
 int 21h
