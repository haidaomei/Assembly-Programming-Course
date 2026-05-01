data segment
    maxlen db 14
    actlen db ?
    str db 14 dup('$'),'$'
    crlf db 13,10,'$'
data ends

code segment
assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax
    
    ;输入字符串
    mov ah, 0Ah
    lea dx, maxlen
    int 21h
    
    ;输出换行
    mov ah, 09h
    lea dx, crlf
    int 21h
    
    ;输出字符串
    mov ah, 09h
    lea dx, str
    int 21h
    
    ;程序结束
    mov ah, 4Ch
    int 21h
code ends
end start