data segment
    x dw 0020h
    y dw 0016h
    z dw ?
    t dw 0fff2h
    w dw 0020h
    r dw ?
data ends
code segment
    assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax
    mov ax,w
    mul x
    mov bx,dx
    mov cx,ax
    mov ax,t
    cwd
    add cx,ax
    adc bx,dx;一定要加adc add我试过得到错误的结果 这个题专门设计了低16位进位
    sub y,6
    mov ax,cx
    mov dx,bx
    div y
    mov z,ax
    mov r,dx
    mov ax,4c00h
    int 21h
code ends
    end start