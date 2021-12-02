assume cs:code
stack segment 
	db	128 dup(0)
stack ends

code segment
start:
	mov ax,stack
	mov ss,ax
	mov sp,128
	
	push cs
	pop ds
	
	mov ax,0
	mov es,ax
	
	mov si,OFFSET int9
	mov di,204H
	mov cx,OFFSET int9end - offset int9
	cld
	rep movsb
	
	push es:[9*4]
	pop es:[200H]
	push es:[9*4+2]
	pop es:[202H]

	
	cli
	mov word ptr es:[9*4],204H
	mov word ptr es:[9*4+2],0
	sti
	
	mov ax,4c00h
	int 21H
	
	
int9:
	push ax
	push bx
	push cx
	push es
	
	
	
	in al,60H
	pushf
	call dword ptr cs:[200h]
	
	cmp al,3bh
	jne int9ret
	
	mov ax,0B800H
	mov es,ax
	mov bx,1
	mov cx,2000
s:	
	inc byte ptr es:[bx]
	add bx,2
	loop s
	
int9ret:
	pop es
	pop cx
	pop bx
	pop ax
	iret

int9end:
	nop

code ends
end start	
	
	
	mov ax,4C00H	
	int 21H
code ends
end  start
