;-----------------------------------------------------------
;该程序将CMOS RAM中的时间信息打印在屏幕上，并且通过为每一个数
;字绘制相应的数字图形符号
;-----------------------------------------------------------
assume	cs:code, ds:data, ss:stack

stack	segment
	dw	128 dup(0)
stack	ends

data	segment
	table	dw	show0, show1, show2, show3, show4, show5, show6, show7, show8, show9
data	ends

code	segment
start:	mov	ax, stack
	mov	ss, ax
	mov	sp, 128

	mov	ax, data
	mov	ds, ax
	
	mov	cx, 2000
	call	clear
	mov	bx, 0

time:	mov	cx, 1500
	call	clear
	
	mov	dh, 2
	mov	dl, 2
	call	show2

	mov	dl, 9
	call	show0

	mov	al, 9
	call	cacu

	mov	dh, 2
	mov	dl, 15
	call	word ptr table[bx]

	mov	bl, al
	cmp	al, 0AH
	jne	timeGOON

timeGOON:
	mov	dl, 21
	call	word ptr table[bx]

	mov	dl, 29
	call	juhao
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov	al, 8
	call	cacu

	mov	dh, 2
	mov	dl, 32
	call	word ptr table[bx]

	mov	bl, al
	mov	dl, 39
	call	word ptr table[bx]
	
	mov	dl, 46
	call	juhao
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov	al, 7
	call	cacu

	mov	dl, 49
	call	word ptr table[bx]

	mov	bl, al
	mov	dl, 56
	call	word ptr table[bx]

	mov	dl, 63
	call	juhao
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	以上输出年月日
	mov	al, 4
	call	cacu

	mov	dh, 9
	mov	dl, 29
	call	word ptr table[bx]

	mov	bl, al
	mov	dl, 36
	call	word ptr table[bx]

	mov	dl, 43
	call	maohao
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov	al, 2
	call	cacu
	mov	dh, 9
	
	mov	dl, 47
	call	word ptr table[bx]

	mov	bl, al
	mov	dl, 54
	call	word ptr table[bx]

	mov	dl, 61
	call	maohao
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov	al, 0
	call	cacu
	
	mov	dl, 65
	call	word ptr table[bx]

	mov	bl, al
	mov	dl, 72
	call	word ptr table[bx]
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	call	delay
	
	jmp	time

	
	mov	ax, 4C00H
	int	21H
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;名称：显示0
;参数：dh：显示的行号；dl：显示的列号
;返回：无
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
show0:	push	ax
	push	es
	push	bx
	push	cx

	mov	ax, 0B800H
	mov	es, ax
	
	mov	al, 160
	mul	dh
	mov	bx, ax
	mov	al, 2
	mul	dl
	add	bx, ax

	mov	cx, 5
show01:	mov	es:[bx], 2420H
	add	bx, 2
;	inc	ax
	loop	show01

	add	bx, 4*160-10
	mov	cx, 5
show02:	mov	es:[bx], 2420H
	add	bx, 2
	loop	show02				;横线
	
	sub	bx, 4*160+10
;	mov	ax, 2441H
	mov	cx, 5
show03:	mov	es:[bx], 2420H
;	mov	es:[bx], ax
	add	bx, 160
;	inc	ax
	loop	show03

	sub	bx, 5*160-2
	mov	cx, 5
show04:	mov	es:[bx], 2420H
	add	bx, 160
	loop	show04

	sub	bx, 5*160-6
	mov	cx, 5
show05:	mov	es:[bx], 2420H
	add	bx, 160
	loop	show05

	sub	bx, 5*160-2
	mov	cx, 5
show06:	mov	es:[bx], 2420H
	add	bx, 160
	loop	show06

	pop	cx
	pop	bx
	pop	es
	pop	ax
	ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;show1
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
show1:	push	ax
	push	es
	push	dx
	push	bx
	push	cx
	
	mov	ax, 0B800H
	mov	es, ax

	mov	al, 160
	mul	dh
	mov	bx, ax
	mov	al, 2
	mul	dl
	add	bx, ax

	mov	es:[bx+2], 2420H

	push	bx
	mov	cx, 5
show10:	mov	es:[bx+4], 2420H
	add	bx, 160
	loop	show10

	sub	bx, 5*160-2
	mov	cx, 5
show11:	mov	es:[bx+4], 2420H
	add	bx, 160
	loop	show11

	pop	bx
	add	bx, 4*160+2
	mov	cx, 4
show12:	mov	es:[bx], 2420H
	add	bx, 2
	loop	show12

	pop	cx
	pop	bx
	pop	dx
	pop	es
	pop	ax
	ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;show2
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
show2:	push	ax
	push	es
	push	dx
	push	bx
	push	cx
	
	mov	ax, 0B800H
	mov	es, ax

	mov	al, 160
	mul	dh
	mov	bx, ax
	mov	al, 2
	mul	dl
	add	bx, ax

	call	Print

	push	bx
	add	bx, 160+8
	mov	es:[bx], 2420H
	add	bx, 2
	mov	es:[bx], 2420H

	pop	bx
	add	bx, 3*160
	mov	es:[bx], 2420H
	add	bx, 2
	mov	es:[bx], 2420H

	pop	cx
	pop	bx
	pop	dx
	pop	es
	pop	ax
	ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;show3
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
show3:	push	ax
	push	es
	push	dx
	push	bx
	push	cx
	
	mov	ax, 0B800H
	mov	es, ax

	mov	al, 160
	mul	dh
	mov	bx, ax
	mov	al, 2
	mul	dl
	add	bx, ax
	
	call	Print

	push	bx
	add	bx, 160+8
	mov	es:[bx], 2420H
	add	bx, 2
	mov	es:[bx], 2420H

	pop	bx
	add	bx, 3*160+8
	mov	es:[bx], 2420H
	add	bx, 2
	mov	es:[bx], 2420H

	pop	cx
	pop	bx
	pop	dx
	pop	es
	pop	ax
	ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;show5
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
show5:	push	ax
	push	es
	push	dx
	push	bx
	push	cx
	
	mov	ax, 0B800H
	mov	es, ax

	mov	al, 160
	mul	dh
	mov	bx, ax
	mov	al, 2
	mul	dl
	add	bx, ax

	call	Print

	push	bx
	add	bx, 160
	mov	es:[bx], 2420H
	add	bx, 2
	mov	es:[bx], 2420H

	pop	bx
	add	bx, 3*160+8
	mov	es:[bx], 2420H
	add	bx, 2
	mov	es:[bx], 2420H

	pop	cx
	pop	bx
	pop	dx
	pop	es
	pop	ax
	ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;show6
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
show6:	push	ax
	push	es
	push	dx
	push	bx
	push	cx
	
	mov	ax, 0B800H
	mov	es, ax

	mov	al, 160
	mul	dh
	mov	bx, ax
	mov	al, 2
	mul	dl
	add	bx, ax

	call	Print

	push	bx
	push	bx
	add	bx, 160
	mov	es:[bx], 2420H
	add	bx, 2
	mov	es:[bx], 2420H

	pop	bx
	add	bx, 3*160+8
	mov	es:[bx], 2420H
	add	bx, 2
	mov	es:[bx], 2420H
	
	pop	bx
	add	bx, 3*160
	mov	es:[bx], 2420H
	add	bx, 2
	mov	es:[bx], 2420H

	pop	cx
	pop	bx
	pop	dx
	pop	es
	pop	ax
	ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;show8
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
show8:	push	ax
	push	es
	push	dx
	push	bx
	push	cx
	
	mov	ax, 0B800H
	mov	es, ax

	mov	al, 160
	mul	dh
	mov	bx, ax
	mov	al, 2
	mul	dl
	add	bx, ax

	call	Print

	push	bx
	push	bx
	push	bx
	add	bx, 160
	mov	es:[bx], 2420H
	add	bx, 2
	mov	es:[bx], 2420H

	pop	bx
	add	bx, 160+8
	mov	es:[bx], 2420H
	add	bx, 2
	mov	es:[bx], 2420H

	pop	bx
	add	bx, 3*160+8
	mov	es:[bx], 2420H
	add	bx, 2
	mov	es:[bx], 2420H

	pop	bx
	add	bx, 3*160
	mov	es:[bx], 2420H
	add	bx, 2
	mov	es:[bx], 2420H

	pop	cx
	pop	bx
	pop	dx
	pop	es
	pop	ax
	ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;show9
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
show9:	push	ax
	push	es
	push	dx
	push	bx
	push	cx
	
	mov	ax, 0B800H
	mov	es, ax

	mov	al, 160
	mul	dh
	mov	bx, ax
	mov	al, 2
	mul	dl
	add	bx, ax

	call	Print

	push	bx
	push	bx
	add	bx, 160
	mov	es:[bx], 2420H
	add	bx, 2
	mov	es:[bx], 2420H

	pop	bx
	add	bx, 160+8
	mov	es:[bx], 2420H
	add	bx, 2
	mov	es:[bx], 2420H

	pop	bx
	add	bx, 3*160+8
	mov	es:[bx], 2420H
	add	bx, 2
	mov	es:[bx], 2420H

	pop	cx
	pop	bx
	pop	dx
	pop	es
	pop	ax
	ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Print 3 lines
;参数：dh行，dl列
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Print:	push	ax
	push	es
	push	dx
	push	bx
	push	cx
	
	mov	ax, 0B800H
	mov	es, ax

	mov	al, 160
	mul	dh
	mov	bx, ax
	mov	al, 2
	mul	dl
	add	bx, ax

	mov	cx, 6
Print0:	mov	es:[bx], 2420H
	add	bx, 2
	loop	Print0

	add	bx, 2*160-12
	mov	cx, 6
Print1:	mov	es:[bx], 2420H
	add	bx, 2
	loop	Print1

	add	bx, 2*160-12
	mov	cx, 6
Print2:	mov	es:[bx], 2420H
	add	bx, 2
	loop	Print2

	pop	cx
	pop	bx
	pop	dx
	pop	es
	pop	ax
	ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;show4
show4:	push	ax
	push	bx
	push	cx
	push	dx
	push	es

	mov	ax, 0B800H
	mov	es, ax

	mov	al, 160
	mul	dh
	mov	bx, ax
	mov	al, 2
	mul	dl
	add	bx, ax
	push	bx

	mov	cx, 3
show40:	mov	es:[bx], 2420H
	add	bx, 160
	loop	show40

	sub	bx, 3*160-2
	mov	cx, 3
show41:	mov	es:[bx], 2420H
	add	bx, 160
	loop	show41

	pop	bx
	add	bx, 2*160
;	mov	ax, 2441H
	mov	cx, 6
show42:	mov	es:[bx], 2420H
	add	bx, 2
	loop	show42
	
	sub	bx, 2*160+4
	mov	cx, 5
show43:	mov	es:[bx], 2420H
	add	bx, 160
	loop	show43

	sub	bx, 5*160-2
	mov	cx, 5
show44:	mov	es:[bx], 2420H
	add	bx, 160
	loop	show44

	pop	es
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;show7
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
show7:	push	ax
	push	bx
	push	cx
	push	dx
	push	es

	mov	ax, 0B800H
	mov	es, ax

	mov	al, 160
	mul	dh
	mov	bx, ax
	mov	al, 2
	mul	dl
	add	bx, ax

	mov	cx, 6
show70:	mov	es:[bx], 2420H
	add	bx, 2
	loop	show70

	sub	bx, 2
	mov	cx, 5
show71:	mov	es:[bx], 2420H
	add	bx, 160
	loop	show71

	sub	bx, 5*160+2
	mov	cx, 5
show72:	mov	es:[bx], 2420H
	add	bx, 160
	loop	show72

	sub	bx, 5*160-2
	mov	cx, 5
show73:	mov	es:[bx], 2420H
	add	bx, 160
	loop	show73

	pop	es
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;输出一个句号
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
juhao:	push	ax
	push	bx
	push	dx
	push	es

	mov	ax, 0B800H
	mov	es, ax

	mov	al, 160
	mul	dh
	mov	bx, ax
	mov	al, 2
	mul	dl
	add	bx, ax

	add	bx, 4*160
	mov	es:[bx], 2420H
	mov	es:[bx+2], 2420H

	pop	es
	pop	dx
	pop	bx
	pop	ax
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;输出一个冒号
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
maohao:	push	ax
	push	bx
	push	dx
	push	es
	
	mov	ax, 0B800H
	mov	es, ax

	mov	al, 160
	mul	dh
	mov	bx, ax
	mov	al, 2
	mul	dl
	add	bx, ax

	push	bx
	add	bx, 160+2
	mov	es:[bx], 2420H
	mov	es:[bx+2], 2420H

	pop	bx
	add	bx, 3*160+2
	mov	es:[bx], 2420H
	mov	es:[bx+2], 2420H

	pop	es
	pop	dx
	pop	bx
	pop	ax
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Caculate bx
;参数：al存储要取的CMOS RAM中的地址
;返回：bx中存储需要调用的第一个函数的地址
;	ax中存储需要调用的第二个函数的地址
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
cacu:	push	cx
	
	out	70H, al
	in	al, 71H
	mov	ah, al
	mov	cl, 4
	shr	ah, cl
	and	al, 00001111B
	add	ah, ah
	add	al, al
	mov	bl, ah

	pop	cx
	ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;名称：清屏
;参数：cx
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
clear:	push	ax
	push	es
	push	bx
	push	cx
	
	mov	ax, 0B800H
	mov	es, ax
	mov	bx, 0

clearL:	mov	word ptr es:[bx], 0020H
	add	bx, 2
	loop	clearL

	pop	cx
	pop	bx
	pop	es
	pop	ax
	ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;名称：delay
;参数：无
;返回：无
delay:	push	dx
	push	ax

	mov	dx, 5
	mov	ax, 0
delayL:	sub	ax, 1
	sbb	dx, 0
	cmp	dx, 0
	jne	delayL
	cmp	ax, 0
	jne	delayL

	pop	ax
	pop	dx
	ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;ontime:	push	all
	
	cmp	al, 0AH
;	jne	ontimeret
	

;	pop	all
;ontimeret:
	ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

code	ends
end	start