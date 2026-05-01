data segment
    mess db 'COMPUTER'
    str1 db 'found$'
    str2 db 'nofound$'
data ends
code segment
    assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax
    mov es,ax;不添加会错误输出
    ;
    lea di,mess
    mov al,'T'
    mov cx,8
    cld
    repne scasb
    ;
    jz found
    jmp nofound
found:
    mov ah,09h
    lea dx,str1
    int 21h
    jmp exit
nofound:
    mov ah,09h
    lea dx,str2
    int 21h
    jmp exit
exit:
    mov ax,4c00h
    int 21h
code ends
    end start