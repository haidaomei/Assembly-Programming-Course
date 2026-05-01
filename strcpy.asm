data segment
    maxlen1 db 14;注意解析接下来三条语句结构
    actlen1 db ?
    s1 db 14 dup(?);s1复制到s2,maxlen是最大长,actlen是实际长
    s2 db 14 dup('$'),'$'
    mess0 db 13,10,'$'
    mess1 db 'please input s1:$'
    mess2 db 's2:$'
data ends
code segment
    assume cs:code,ds:data
start:
    mov ax,data
    mov ds,ax
    mov es,ax
    mov ah,09h
    lea dx,mess1
    int 21h
    ;输入s1,输入的命令是dos给出定义的,它以为传给它的指针就是缓冲区,所以这里需要主动对接传缓冲区过去,也就是传maxlen而不是s1
    mov ah,0ah
    lea dx,maxlen1
    int 21h
    ;输出回车换行
    mov ah,09h;09h是dos的输出字符串指令,02h是输出字符指令
    lea dx,mess0
    int 21h
    ;复制
    lea si,s1
    lea di,s2
    mov cl,actlen1
    mov ch,0;主要是高字节清零,如果前面没用到估计也不用(ch是cl高字节,组合成cx)
    cld;上面我尝试加了一个mov df,0发现这样之后输出首字符不对
    rep movsb;重复串传送,使用到si、di、cl
    ;
    mov ah,09h
    lea dx,mess2
    int 21h
    mov ah,09h
    lea dx,s2
    int 21h
    mov ax,4c00h
    int 21h
code ends
    end start