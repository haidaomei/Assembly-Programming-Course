data segment
    a db 'qwertyuiopasdfghjklzxcvbnm',0dh,0ah,'$'
    n equ $-a-3
data ends
program segment
main proc far
    assume cs:program,ds:data
start:
    push ds
    sub ax,ax
    push ax
    mov ax,data
    mov ds,ax
;以下
    mov cx,n
    dec cx
loop1:
    mov di,cx
    mov bx,0
    loop2:
        mov al,a[bx];注意bx不能改bl,因为括号内是偏移地址地址是16位的
        cmp al,a[bx+1];这里改了,因为字变成字节所以要用al,地址切换也是+1不是+2
        jge continue
        xchg al,a[bx+1]
        mov a[bx],al;其实就是xchg a[bx],a[bx+1]但是不允许对两个内存条上的玩意交换,所以必须用ax辅助
    continue:
        add bx,1;这里从+2变成+1
        loop loop2
    mov cx,di
    loop loop1
;以上
    lea dx,a
    mov ah,09h
    int 21h
    ret
main endp
program ends
    end start;之前书中的程序这里又不写start现在这里又写= =