;------------------------------------------- 
data    segment 
A dw  5678h,1234h
B dw  0def0h,9abch 
mess1   db  'A>B$' 
mess2   db  'A<=B$' 
data    ends 
;------------------------------------------- 
code    segment 
assume cs:code,ds:data 
start: 
mov ax,data 
mov ds,ax 
mov dx,A+2      
mov ax,A       
mov bx,B+2       
mov cx,B    
cmp dx,bx 
jg  greater    
jl  less         
cmp ax,cx 
ja  greater      
less: 
lea dx,mess2 
jmp output   
greater: 
lea dx,mess1 
output: 
mov ah,09h 
int 21h 
mov ax,4c00h 
int 21h 
code    ends 
;------------------------------------------- 
end start