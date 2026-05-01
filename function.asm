data segment
    oper1 dw 12
    oper2 dw 45
    result dw ?
    right_msg db 'right',0dh,0ah,'$'
    wrong_msg db 'wrong',0dh,0ah,'$'
    crlf db 0dh,0ah,'$'
data ends

code segment
main proc far
    assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax
    mov ax,oper1
    add ax,oper2
    mov result,ax
    lea dx,str+32;我也想不通为什么这样做,既然题目给出的data段没有放置12+45=该字符串,我只能尝试将其放到code段,但是发现没+32之前输出的字符串前有非常多乱码,猜测是str前面的cs段的内存导致,于是尝试对str加加减减,发现加的时候确实能减少前面的乱码字数,尝试到32刚好完美输出字符串,但是如果可以把字符串放到data段那直接dos09h+21h中断实现就非常容易提示用户输入
    mov ah,09h
    int 21h
    jmp continue
    str db '12+45=$'
continue:
    call binidec
    call decibin;上面返回到bx,下面直接和result
    cmp result,bx
    je right
    jmp wrong
right:;显示信息
    lea dx,right_msg
    mov ah,09h
    int 21h
    jmp return
wrong:
    lea dx,wrong_msg
    mov ah,09h
    int 21h
    jmp return
return:
    mov ax,4c00h
    int 21h
main endp


binidec proc near;显示十进制数据
    mov cx,10000d
    call dec_div
    mov cx,1000d
    call dec_div
    mov cx,100d
    call dec_div
    mov cx,10d
    call dec_div
    mov cx,1d
    call dec_div
    ret
    dec_div proc near;这是一个嵌套的
        mov ax,bx
        mov dx,0
        div cx
        mov bx,dx
        mov dl,al
        add dl,30h
        ;mov ah,02h
        ;int 21h
        ret
    dec_div endp
binidec endp

decibin proc near;输入十进制数据
    mov bx,0
newchar:
    mov ah,1;其实就是01h
    int 21h
    sub al,30h
    jl exit
    cmp al,9d
    jg exit
    cbw
    xchg ax,bx
    mov cx,10d
    mul cx
    xchg ax,bx
    add bx,ax
    jmp newchar
exit:
    ret
decibin endp;返回一个存在bx中的数

code ends
    end start