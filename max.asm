data segment
    array dw 4,6fffh,34,100,5ah,6b3h,1,0f234h,6,10
    n dw 10
    max dw ?
data ends
code segment
    assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax
;把初始最大值加载到max
    mov ax,array[0]
    mov max,ax;注意不能直接mov
;加载计数次数到cx
    mov cx,n
    dec cx;这里不能mov cx,n-1
;循环
loop1:
    add bx,2
    mov ax,array[bx];将array[bx]的值加载到ax
    mov dx,max;将array[bx-2]的值加载到dx
    cmp ax,dx;比较ax(现阶段值)和dx(max值),不能用两个内存条上的
    jle skip;如果ax<dx跳过
    mov max,ax;否则ax>dx将ax即array[bx]存入max
skip:
    loop loop1
    mov ax,max;放到ax debug可看
    mov ah,4ch
    int 21h
code ends
    end start