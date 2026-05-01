data segment
    s1 db 'personal computer'
    s2 db 'personal computer'
    mess1 db 'match.$'
    mess2 db 'no match.$'
data ends
code segment
    assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax
    mov es,ax
    lea si,s1
    lea di,s2
    mov cx,17
    cld
    rep cmpsb;si源串偏移地址,di目标串偏移地址,cx比较次数,cmpsb重复比较字节,cmpsw重复比较字,都是直到cx为0或比较结果不相等
    jz match
    lea dx,mess2
    jmp disp
match:
    lea dx,mess1
disp:
    mov ah,09h
    int 21h
    mov ax,4c00h
    int 21h
code ends
    end start