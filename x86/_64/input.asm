;   ASM Sandbox Programm
;
;   Arch        :   x86_64
;   Compiler    :   NASM
;   OS          :   Linux 4.8.4-1
;
;   Description : A poorly made program
;                 to experiment with the sys_read call
;    
;   Output      : A simple Hello <Your Name>
;
;   Note        : Memory management is terrible, exec with your own risk
;
;#######################################################################

section .bss

   buffer: resb 0x20           ; Reserve 32 bytes for stdin read 

section .data

    pmt: db "What's your name : "
    msg: db 'Hello '

section .text

    global _start

_start:

;   sys_write
;   ----------------
    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, pmt
    mov edx, 0x13

    int 0x80
;   ----------------

;   sys_read
;   ----------------
    mov eax, 0x3
    mov ebx, 0x0
    mov ecx, buffer
    mov edx, 0x20               ; Read 32 bytes from stdin fd

    int 0x80
;   ----------------

    mov eax, 0x0                ; Reset EAX
    
    append:
        mov bl, [buffer + eax]      ; Move buffer char by char into bl

        mov [msg + 0x6 + eax], bl   ; Append BL (buffer char) onto msg
        
        inc eax
        cmp eax, 0x20
        jne append

;   sys_write
;   ----------------
    mov eax,0x4
    mov ebx,0x1
    mov ecx,msg

    mov edx,0x6
    add edx,0x20

    int 0x80
;   --------------

;   sys_exit
;   ------------
    mov eax,0x1
    mov ebx,0x0

    int 0x80
;   ------------
