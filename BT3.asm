include lib1.asm
.model small
.stack 100h
.Data
	gtcn1 db 13,10,'	        Dao Xau'
		  db 13,10,' -----------------------------------------------$'
	TB1 db 'Nhap vao 1 xau:', 13, 10, '$'
	TB2 db 13, 10, 13, 10, 'Xau voi thu tu nguoc lai:', 13, 10, '$'
	cn1_c3 db 13,10,'Co tiep tuc CT (c/k)? $'
.Code
PUBLIC BT3
BT3 Proc
		push ax bx cx dx
		MOV AX, @Data
     	MOV DS, AX
	L0:
		clrscr
		LEA DX, TB1 ;Chức năng hiện 1 xâu (kết thúc bằng 
		MOV AH, 9	;dấu ‘$’ ) lên màn hình tại vị trí con 
		INT 21H		
		XOR CX, CX	;CX=0 (phần số đã vào trước, lúc đầu=0)	
		MOV AH, 1
		JMP DOC_TIEP 		
	BACKSPACE: 
        CMP CX, 0  ; Nếu số kí tự nhập vào = 0
        JE DOC_TIEP
        MOV AH, 2  ; Xóa Ký Tự Trên màn Hình
        MOV DX, 0
        INT 21H
        MOV DX, 8
        INT 21H
        MOV AH, 1  
		POP DX     ; Dua ki tu nhap truoc ki tu Backspace ra khoi Stack
		DEC CX     ; Giam bien dem so ki tu di 1
	DOC_TIEP:
        INT 21H		 
        CMP AL,13  ; Neu ki tu nhap vao la Enter	
		JE DUNG_DOC; thi dung doc	
		CMP AL, 8  ; Neu ki tu nhap vao la Backspace
		JE BACKSPACE	
		PUSH AX		 
		INC CX		
		JMP DOC_TIEP
		
	DUNG_DOC:	 
        CMP CX, 0
        JE DOC_TIEP
        LEA DX,TB2		
		MOV AH,9
		INT 21H		
		MOV AH,2	
			
	HIEN_THI:	
	    POP DX		 
		INT 21H
		LOOP HIEN_THI
		
		MOV DX, 13
		INT 21H
		MOV DX, 10
		INT 21H
		
		HienString cn1_c3
		MOV AH, 1
		INT 21H
		cmp  al,'c'		; Ký tự vừa nhận có phải là ký tự ‘c’ ?
		jne  Exit		; Nếu không phải thì nhảy đến nhãn Exit (về DOS)
		jmp  L0		; Còn không thì quay về đầu (bắt đầu lại chương trình)
	Exit:
		pop dx cx bx ax
		ret
BT3 Endp
END BT3
