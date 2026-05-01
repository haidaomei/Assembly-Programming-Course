program segment
main proc far
    assume cs:program
start:
    push ds
    sub ax,ax
    push ax
    ;配合return用
    mov ch,4
    mov bx,1010101010101010b;自己设置的AAAAh
rotate:
    mov cl,4
    rol bx,cl
    mov al,bl
    and al,0fh
    add al,30h
    cmp al,3ah
    jl printit
    add al,7h
printit:
    mov dl,al
    mov ah,2
    int 21h
    dec ch
    jnz rotate
    ret
main endp
program ends
    end;书里面写的是end 但是在vscode下载最高的汇编环境会fatal no program entry point(dosbox0.74-3+masm611没问题) 控制变量调试后发现要加start