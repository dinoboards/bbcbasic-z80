; BASIC ROM VERSION
; 7 6 5 4 3 2 1 0
; | | | | +-+-+-+-- CHARACTER SET
; | | | |           0 = JAPANESE, 1 = INTERNATIONAL (ASCII), 2=KOREAN
; | +-+-+---------- DATE FORMAT
; |                 0 = Y-M-D, 1 = M-D-Y, 2 = D-M-Y
; +---------------- DEFAULT INTERRUPT FREQUENCY
;                   0 = 60HZ, 1 = 50HZ
IDBYT1		EQU	$002B

; FC9E-FC9F: SOFTWARE CLOCK, UPDATED AT EACH VDP INTERRUPT
JIFFY:          EQU     $FC9E           ; TIMER COUNTER

; FCC1-FCC4: INFORMATION FOR EACH PRIMARY SLOT. THE MOST SIGNIFICANT BIT IS
; SET IF THE PRIMARY SLOT IS FOUND TO BE EXPANDED.
EXPTBL:         EQU     $FCC1

; FUNCTION : READS THE VALUE OF AN ADDRESS IN ANOTHER SLOT
; INPUT    : A  - EXXXSSPP
;            |        || PRIMARY  SLOTNUMBER  (00-11)
;            |        - SECUNDARY SLOTNUMBER (00-11)
;            +----------- EXPANDED SLOT (0 = NO, 1 = YES)
;            HL - ADDRESS TO READ
; OUTPUT   : A  - CONTAINS THE VAULE OF THE READ ADDRESS
; REGISTERS: AF, C, DE
; REMARK   : THIS ROUTINE TURNS OFF THE INTERUPT, BUT WON'T TURN IT ON AGAIN
RDSLT:		EQU	$000C

; Function : Clears the screen
; Registers: AF, BC, DE
; Remark   : Zero flag must be set to be able to run this routine
;            XOR A will do fine most of the time
CLS:		EQU	$00C3

; Function : Executes inter-slot call.
; Input    : IY - High byte with slot ID, see RDSLT
;            IX - The address that will be called
; Remark   : Variables can never be given in alternative registers or IX and IY
CALSLT:		EQU	$001C
