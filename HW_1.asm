
;Mert Olpak 040190737 HW_1

.model small
.data
Dizi DB 45, 0, 28, 76, 45, 0, 0, 14, 32, 27, 14, 39, 0, 68, 15, 23, 0, 14, 42, 27
N EQU 20

.code
Basla PROC
.STARTUP

MOV AX, 0
MOV BX, 0
MOV SI, 1

JMP ANA_DONGU

Sonraki_Eleman:
MOV SI, 1
INC BX
CMP BX, N ;Check if first step is completed
JE Finish_step1

ANA_DONGU:
MOV CX, SI
ADD CX, BX
CMP CX, N ;Check if there are no other members left on the right side to compare
JE Sonraki_Eleman ;Switch to the next member to compare with the others on the right

MOV AL, Dizi[BX] 
MOV DL, Dizi[BX+SI]
CMP AL, DL
JE SIL
INC SI
JMP ANA_DONGU ;Dup not found, check with the member on right-next

SIL:
MOV Dizi[BX+SI], 0
INC SI
JMP ANA_DONGU

Finish_step1:

MOV AX, 0
MOV BX, 0
MOV SI, 1
MOV CX, 0
MOV DX, 0

JMP ANA_DONGU_2



ANA_DONGU_2:

MOV BX, 0
MOV SI, 1

Devam_2:

MOV AL, Dizi[BX]
CMP AL, 0
JE Devam ;First condition is met (selected member=0), check the next non-zero member
INC BX
JMP Devam_2 

Devam:

MOV DL, Dizi[BX+SI]
CMP DL, 0
JNE switch_w_left ;Second condition is met switch zero with closest non-zero member on the right
INC SI ;Check the one-step-right member
ADD CX, SI
ADD CX, BX
CMP CX, N+1 ;Check if we are all done
JE Finish_All
MOV CX, 0
JMP Devam


switch_w_left: ;Switching function
MOV AH, Dizi[BX+SI]
MOV Dizi[BX], AH
MOV Dizi[BX+SI], 0
JMP ANA_DONGU_2 ;Switching done, go back to beginning

Finish_All:

.EXIT
Basla ENDP
END Basla