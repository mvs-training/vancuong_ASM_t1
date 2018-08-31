INCLUDE lib1.asm
.MODEL small
.data
    tb1 db 'Nhap vao so thu nhat: $'
    tb2 db 13, 10, 'Nhap vao so thu hai: $'
    tb3 db 13, 10, 'Tong cua hai so la: $' 
    tb4 db 13, 10, 'Tran so...$'
	CT db 13,10,'Co tiep tuc CT (c/k)? $'
.stack 100h 
.code
PUBLIC BT1
BT1 Proc
		push ax bx cx dx
	L0:
        MOV AX, @Data
     	MOV DS, AX
		clrscr
     	;Nhap so thu nhat
		HienString tb1
        CALL READ_NUM ; Kiểm Tra đầu vào
     	PUSH BX
        ;Nhap so thu hai
		HienString tb2
        CALL READ_NUM
        MOV DX, BX ;DX chua gia tri so thu hai
		POP BX     ;BX chua gia tri so thu nhat
        ;Tinh tong 2 so
		ADD BX, DX
		JC TRAN_SO ;Nhảy nếu tràn số
		;Hien thi tong hai so
        MOV AH, 9
		LEA DX, TB3
		INT 21H
		MOV AH, 2
		MOV CX, 16
	LAP:
		MOV DX, 8000H ;Dua bit cao nhat cua BX
		AND DX, BX	  ;vao bit cao nhat cua DX
		SHR DX, 15	  ;Dich phai 15 bit de DX = 1
		ADD DX, 48
		INT 21H
		SHL BX, 1
		LOOP LAP
		JMP HIEN
	TRAN_SO:
		MOV AH, 9
		LEA DX, TB4
		INT 21H
	HIEN: 
        MOV AH, 2
        MOV DX, 13
        INT 21H
        MOV DX, 10
        INT 21H
		HienString CT
        MOV AH, 1
		INT 21H
		cmp al,'c'	; Ký tự vừa nhận có phải là ký tự ‘c’ ?
		jne Exit	; Nếu không phải thì nhảy đến nhãn Exit (về DOS)
		jmp L0		; Còn không thì quay về đầu (bắt đầu lại chương trình)
	Exit:
		pop dx cx bx ax
		ret 		
BT1 ENDP
     	
;Thu tuc nhap vao 1 so nhi phan 16 bit
READ_NUM PROC NEAR
     	XOR BX, BX
		XOR CX, CX
		JMP READ
	BACK:
        CMP CX, 0 ;Chua co chu so nao 
        JE READ   ;thi nhay den READ
        MOV AH, 2
        MOV DX, 0
        INT 21H
        MOV DX, 8
        INT 21H
        SHR BX, 1
        DEC CX
        JMP READ        
	ERROR: ;Xoa ki tu vua nhap
        MOV AH, 2
        MOV DX, 8
        INT 21H
        MOV DX, 0
        INT 21H              
        MOV DX, 8
        INT 21H        
	READ:
        MOV AH, 1
        INT 21H
        CMP AL, 13 ; Neu go ki tu Enter
        JE STOP
        CMP AL, 8  ; Neu go ki tu Backspace
        JE BACK
        CMP CX, 16 ; Khong cho nhap nua neu da nhap du 16 chu so (16 bit)
        JE ERROR 
        CMP AL, 48
        JL ERROR   ; Khong cho nhap cac ki tu khac, 
        CMP AL, 49 ; ngoai '0', '1', Enter va Backspace.
        JG ERROR
        AND AL, 0001H
		XOR AH, AH
		SHL BX, 1
		OR BX, AX
        INC CX
        JMP READ        
	STOP:
        CMP CX, 0  
        JE READ
        RET     	    
READ_NUM ENDP
INCLUDE lib2.asm
END BT1