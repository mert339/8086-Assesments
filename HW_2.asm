.model small
.data
Cumle DB 'Filling  : 1 (true) 0 (false)',0ah,'Movement: Left, Right, Up, Down',0ah,'Exit    : ESC$'
;-------------------------------------------
; Dimensions of rectangle (in pixels)
rwidth equ 70 ; Width 
rheight equ 40 ; Height
renk equ 9 ; Light blue color (IRGB = 1001)
;-------------------------------------------
.code
Basla PROC
mov bx, 50 ;top-left column
mov si, 50 ;top-lef row
mov di, 0 ;register that indicates if filling is on
BASA_DON:
 mov cx, bx
 mov dx, si
 mov ah, 0 ; Set video mode as VGA 320x200 pixels
 mov al, 13h ; Select function
 int 10h
;-------------------------------------------
;Top-leftmost coordinates of rectangle: x=100, y=20
; Draw upper horizontal line
 add cx, rwidth ; column
 mov al, renk ; select color
dongu1: 
 mov ah, 0ch ; put one pixel
 int 10h
 dec cx
 cmp cx, bx
 jae dongu1

 ; Draw lower horizontal line
 add cx, rwidth ; column
 add dx, rheight ; row
 mov al, renk ; select color
dongu2: 
 mov ah, 0ch ; put one pixel
 int 10h
 dec cx
 cmp cx, bx
 ja dongu2
;-------------------------------------------
; Draw left vertical line
 mov cx, bx ; column
 mov al, renk ; select color
dongu3: 
 mov ah, 0ch ; put one pixel
 int 10h
 dec dx
 cmp dx, si
 ja dongu3

; Draw right vertical line
 add cx, rwidth ; column
 add dx, rheight ; row
 mov al, renk ; select color
dongu4: 
 mov ah, 0ch ; put one pixel
 int 10h
 dec dx
 cmp dx, si
 ja dongu4 
;-------------------------------------------
 ;Metin adresini yukle
 check_keypress:
 MOV AX, @data
 MOV DS, AX
 LEA DX, Cumle
 ;Metni ekrana yaz
 MOV AH, 09H
 INT 21H
;-------------------------------------------
; Pause the screen, wait for keypress.

mov ah, 10h
int 16h
;------------------------------------------------
 ; There is a keypress.
 CMP AL, 27 ; Compare with ASCII code of Escape Key
 JE bitir
 CMP AL, 48 ;sıfır?
 JE BASA_DON
 CMP AH, 4bh ;sol?
 JE sol
 CMP AH, 4dh ;sag?
 JE sag
 CMP AH, 48h ;yukarı?
 JE yukari
 CMP AH, 50h ;aşağı?
 JE asagi
 jmp BASA_DON

 sol:
 dec bx
 jmp BASA_DON
 sag:
 inc bx
 jmp BASA_DON
 yukari:
 dec si
 jmp BASA_DON
 asagi:
 inc si
 jmp BASA_DON


;CMP AL, 49
;JE doldur
;-------------------------------------------

;doldur:
; mov bx, 90
; mov cx, 50
; mov dx, 50
; mov ah, 0 ; Set video mode as VGA 320x200 pixels
; mov al, 13h ; Select function
 ;int 10h
 ;add cx, rwidth ; column
 ;mov al, renk ; select color
;dongu5: 
 ;mov ah, 0ch ; put one pixel
 ;int 10h
 ;dec cx
 ;cmp cx, 50
 ;jae dongu5
 ;add cx, rwidth
 ;inc dx
 ;cmp dx, bx
 ;jne dongu5
 ;jmp check_keypress


; Return to text mode
bitir:
 mov ah,00 ;Select function
 mov al,03 ;Text mode 3
 int 10h ;BIOS video service
.EXIT
Basla ENDP
END Basla