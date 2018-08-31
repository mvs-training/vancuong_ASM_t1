INCLUDE lib1.asm
.MODEL small
.STACK 100h
.DATA
 gt2 db ' TUAN 1 ',0
 gt3 db 13,10,13,10,'   An phim bat ky de tiep tuc'
     db 13,10,'    con an Esc thi thoat $'
 cn db 13,10,'          CAC CHUC NANG CUA CT CHINH'
    db 13,10,'          ------------***-----------'
    db 13,10,13,10,'    1. Cau 1'
    db 13,10,'    2. Cau 2'
    db 13,10,'    3. Cau 3'
    db 13,10,'    4. Ve man hinh gioi thieu'
    db 13,10,13,10,'    Hay chon: $'
.CODE
	EXTRN BT1:PROC
	EXTRN BT2:PROC
	EXTRN BT3:PROC
PS:
        mov ax,@data ; Đưa phần địa chỉ segment của vùng nhớ dữ
        mov ds,ax		; liệu vào DS
    L0:
        clrscr
        lea si,gt2	;SI con trỏ offset đầu biến xâu cần hiện
        BLINK 10,9,10101100b ;vẽ
        HienString gt3
        mov ah,1	;Chờ nhận 1 ký tự từ bàn phím
        int 21h		;
        cmp al,27	; Ký tự nhận có phải là 'Esc' không
        jne CONTINUE	; Nếu ko phải thì nhảy xuống CONTINUE
        mov ah,4ch	; Chức năng về DOS
        int 21h		;
	CONTINUE:
        clrscr
        HienString cn
        mov ah,1
        int 21h
        cmp al,'1'
        jne Test_2
        call BT1
        HienString CONTINUE
	Test_2:
        cmp al,'2'
        jne Test_3
        call BT2
        jmp CONTINUE
	Test_3:
        cmp al,'3'
        jne Test_4
        call BT3
        jmp CONTINUE
	Test_4:
        cmp al,'4'
        jne Thoat
        jmp L0
	Thoat:
        jmp CONTINUE
        END PS

