data segment
    array dw 10,20h,30,40,50h,60,70,80,90h,100
    m dw 10
    total dw ?
data ends
code segment
    assume cs:code,ds:data
start:
start_loop:
    add ax,array[si]
    add si,2
    loop start_loop
    mov total,ax
    mov ax,4c00h
    int 21h
code ends
    end start