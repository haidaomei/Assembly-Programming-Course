data segment
    char db ?
data ends

code segment
assume cs:code, ds:data
start:
    mov ax, data
    mov ds, ax

    ;从键盘输入字符
    mov ah, 01h
    int 21h
    mov char, al

    ;输出回车和换行
    mov ah, 02h
    mov dl, 0Dh
    int 21h
    mov dl, 0Ah
    int 21h

    ;将小写字母转换为大写字母
    mov al, char
    sub al, 20h

    ;输出转换后的大写字母
    mov dl, al
    mov ah, 02h
    int 21h

    ; 程序结束
    mov ah, 4Ch
    int 21h
code ends
end start