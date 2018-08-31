INCLUDE lib1.asm
.MODEL small
.STACK 100h
.Data 
    tb1 db 'Nhap so thu nhat: $'
    tb2 db 13, 10, 'Nhap so thu hai: $'
    tb3 db 13, 10, 'Tong cua 2 so la: $'
	dautru db '-$'
	CT db 13,10,'Co tiep tuc CT (c/k)? $'
.Code
PUBLIC BT2
BT2 Proc
		push ax bx cx dx
	L0:
		MOV AX, @Data
		MOV DS, AX
		clrscr
		
		; Nhap so thu nhat:
		HienString tb1
		call VAO_SO_N	; Nhận giá trị số thứ 1
		mov bx,ax		; bx = giá trị số thứ 1
		
		; Nhap so thu hai:
		HienString tb2	; Hiện thông báo tb2 (‘Hay vao so thu 2 : ‘)
		call VAO_SO_N	; Nhận giá trị số thứ 2
		
		HienString tb3	; Hiện thông báo tb3 (‘Trung binh cong 2 so nguyen la :’)
		add ax,bx		; Tổng 2 số (ax=ax+bx)
		and ax,ax		; Giá trị tổng là âm hay dương?
		call HIEN_SO_N	; Hiện giá trị
		HienString CT	; Hiện thông báo CT (‘Co tiep tuc CT (c/k)? ‘)
		mov ah,1		; Chờ nhận 1 ký tự từ bàn phím
		int 21h
		cmp al,'c'		; Ký tự vừa nhận có phải là ký tự ‘c’ ?
		jne Exit		; Nếu không phải thì nhảy đến nhãn Exit (về DOS)
		jmp L0		; Còn không thì quay về đầu (bắt đầu lại chương trình)
	Exit:
		pop dx cx bx ax
		ret
BT2 Endp
INCLUDE lib2.asm
END BT2