 LIST P=16F627                ; Define the PIC microcontroller being used
 #include <P16F627.INC>       ; Include device-specific definitions

 __config _INTRC_OSC_NOCLKOUT & _WDT_OFF & _PWRTE_OFF & _MCLRE_OFF & _CP_OFF & _BOD_OFF
                             ; Set configuration bits (internal oscillator, watchdog timer off, etc.)

; -------------------------
; Variable Definitions
; -------------------------

 MainDelay    EQU 0x25        ; Main delay loop variable
 InnerDelay   EQU 0x26        ; Inner delay loop variable
 OuterDelay   EQU 0x27        ; Outer delay loop variable
 BtnState     EQU 0x20        ; Flag to hold button status
 TempStorage  EQU 0x2E        ; Temporary storage 1
 TempStorage2 EQU 0x30        ; Temporary storage 2
 CountReg     EQU 020h
 Dir	      EQU 021h
 ButtonDown   EQU 022h
; -------------------------
; Program Start
; -------------------------

 ORG 0x00
    GOTO Setup               ; Jump to initialization routine

 ORG 0x04                    ; Interrupt vector (not used here)
    RETFIE                  ; Return from interrupt (placeholder)

; -------------------------
; Initialization Routine
; -------------------------

Setup:
    BSF STATUS, RP0         ; Switch to Bank 1
    MOVLW 0x07
    MOVWF CMCON             ; Disable comparators
    CLRF TRISB              ; Set PORTB as output (7-segment display)
    CLRF TRISA
    MOVLW b'11011111';      
    MOVWF TRISA             ; Set RA6 as input for button
    BCF STATUS, RP0         ; Back to Bank 0
    BSF Dir,0
    CLRF PORTB              ; Clear display port
    CLRF PORTA              ; Clear input port

MainLoop:

	Call ReadButtonClick
	
	;BTFSS Dir,0
	;Goto Count_Down
	;Goto Count_UP
UD0:
	
	Call D0
	Call ReadButtonClick
	BTFSS Dir,0
	Goto DD0

UD1:
	
	Call D1
	Call ReadButtonClick
	BTFSS Dir,0
	Goto DD1
	
UD2:
	
	Call D2
	Call ReadButtonClick
	BTFSS Dir,0
	Goto DD2

UD3:
	
	Call D3
	Call ReadButtonClick
	BTFSS Dir,0
	Goto DD3

UD4:
	
	Call D4
	Call ReadButtonClick
	BTFSS Dir,0
	Goto DD4

UD5:
	
	Call D5
	Call ReadButtonClick
	BTFSS Dir,0
	Goto DD5
UD6:
	
	Call D6
	Call ReadButtonClick
	BTFSS Dir,0
	Goto DD6
UD7:
	
	Call D7
	Call ReadButtonClick
	BTFSS Dir,0
	Goto DD7

UD8:
	
	Call D8
	Call ReadButtonClick
	BTFSS Dir,0
	Goto DD8
UD9:
	
	Call D9
	Call ReadButtonClick
	BTFSS Dir,0
	Goto DD9
		
UD10:
	CALL ClearDisplay
	Call D1
	
	Call D0
	Call ReadButtonClick
	BTFSS Dir,0
	Goto DD10

UD11:
	CALL ClearDisplay
	Call D1
	Call D1
	Call ReadButtonClick
	BTFSS Dir,0
	Goto DD11

UD12:
	CALL ClearDisplay
	Call D1
	Call D2
	Call ReadButtonClick
	BTFSS Dir,0
	Goto DD12

UD13:
	CALL ClearDisplay
	Call D1
	Call D3
	Call ReadButtonClick
	BTFSS Dir,0
	Goto DD13

UD14:
	Call D1
	Call D4
	Call ReadButtonClick
	BTFSS Dir,0
	Goto DD14

UD15:
	Call D1
	Call D5
	Call ReadButtonClick
	BTFSS Dir,0
	Goto DD15
	
UD16:
	CALL ClearDisplay
	Call D1
	Call D6
	Call ReadButtonClick
	BTFSS Dir,0
	Goto DD16
	
UD17:
 	 CALL ClearDisplay
	Call D1
	Call D7
	Call ReadButtonClick
	BTFSS Dir,0
	Goto DD17
	
UD18:
	CALL ClearDisplay
	Call D1
	Call D8
	Call ReadButtonClick
	BTFSS Dir,0
	Goto DD18
	
UD19:
 	CALL ClearDisplay
	Call D1
	Call D9
	Call ReadButtonClick
	BTFSS Dir,0
	Goto DD19

UD20:
	CALL ClearDisplay
	Call D2
	Call D0
	Call ReadButtonClick
	BTFSS Dir,0
	Goto DD20

DD20:
	CALL ClearDisplay
	Call D2
	Call D0
	Call ReadButtonClick
	BTFSC Dir,0
	Goto UD20

DD19:
	CALL ClearDisplay
	Call D1
	Call D9
	Call ReadButtonClick
	BTFSC Dir,0
	Goto UD19

DD18:
	CALL ClearDisplay
	Call D1
	Call D8
	Call ReadButtonClick
	BTFSC Dir,0
	Goto UD18
	
DD17:
	CALL ClearDisplay
	Call D1
	Call D7
	Call ReadButtonClick
	BTFSC Dir,0
	Goto UD17
	
DD16:
	CALL ClearDisplay
	Call D1
	Call D6
	Call ReadButtonClick
	BTFSC Dir,0
	Goto UD16
	
DD15:
	CALL ClearDisplay
	Call D1
	Call D5
	Call ReadButtonClick
	BTFSC Dir,0
	Goto UD15
	
DD14:
	CALL ClearDisplay
	Call D1
	Call D4
	Call ReadButtonClick
	BTFSC Dir,0
	Goto UD14
	
	
DD13:
	CALL ClearDisplay
	Call D1
	Call D3
	Call ReadButtonClick
	BTFSC Dir,0
	Goto UD13
	
DD12:
	CALL ClearDisplay
	Call D1
	Call D2
	Call ReadButtonClick
	BTFSC Dir,0
	Goto UD12
	
DD11:
	CALL ClearDisplay
	Call D1
	Call D1
	Call ReadButtonClick
	BTFSC Dir,0
	Goto UD11
	
DD10:
	CALL ClearDisplay
	Call D1
	Call D0
	Call ReadButtonClick
	BTFSC Dir,0
	Goto UD10

DD9:
	
	Call D9
	Call ReadButtonClick
	BTFSC Dir,0
	Goto UD9

DD8:

	Call D8
	Call ReadButtonClick
	BTFSC Dir,0
	Goto UD8

DD7:

	Call D7
	Call ReadButtonClick
	BTFSC Dir,0
	Goto UD7

DD6:

	Call D6
	Call ReadButtonClick
	BTFSC Dir,0
	Goto UD6

DD5:

	Call D5
	Call ReadButtonClick
	BTFSC Dir,0
	Goto UD5

	
	
DD4:

	Call D4
	Call ReadButtonClick
	BTFSC Dir,0
	Goto UD4
	
DD3:

	Call D3
	Call ReadButtonClick
	BTFSC Dir,0
	Goto UD3
	
DD2:

	Call D2
	Call ReadButtonClick
	BTFSC Dir,0
	Goto UD2


DD1:
	
	Call D1
	Call ReadButtonClick
	BTFSC Dir,0
	Goto UD1

DD0:
	
	Call D0
	Call ReadButtonClick
	BTFSC Dir,0
	Goto UD0


	
	
	
	

	CALL RunDelay

        GOTO MainLoop

; -------------------------
; Display Subroutines 0–9 (Up Counting)
; -------------------------

;Count_UP:
;	INCF CountReg,1;
;	Goto Conti
	
;Count_Down:
;	DECF CountReg,1;
;	Goto Conti


D0:
    
    
    MOVLW b'11000000'
    MOVWF PORTB
    CALL RunDelay
    MOVLW 0x00
    MOVWF  CountReg
    RETURN
    
   

D1:
   
    MOVLW b'11111001'
    MOVWF PORTB
    CALL RunDelay
    MOVLW 0x01
    MOVWF  CountReg
    RETURN
   
D2:
 
    MOVLW b'10100100'
    MOVWF PORTB
    CALL RunDelay
    MOVLW 0x02
    MOVWF  CountReg
    RETURN

D3:
  
    MOVLW b'10110000'
	
    MOVWF PORTB
    CALL RunDelay
    MOVLW 0x03
    MOVWF  CountReg
    RETURN

D4:
    
    MOVLW b'10011001'
    MOVWF PORTB
    CALL RunDelay
    MOVLW 0x04
    MOVWF  CountReg
    RETURN

D5:
   
    MOVLW b'10010010'
    MOVWF PORTB
    CALL RunDelay
    MOVLW 0x05
    MOVWF  CountReg
    RETURN

D6:
 
    MOVLW b'10000010'
    MOVWF PORTB
    CALL RunDelay
    MOVLW 0x06
    MOVWF  CountReg
        RETURN

D7:
    MOVLW b'11111000'
    MOVWF PORTB
    CALL RunDelay
    MOVLW 0x07
    MOVWF  CountReg
       RETURN

D8:
    
    MOVLW b'10000000'
    MOVWF PORTB
    CALL RunDelay
    MOVLW 0x08
    MOVWF  CountReg
       RETURN

D9:
   
    MOVLW b'10010000'
    MOVWF PORTB
    CALL RunDelay
    MOVLW 0x09
    MOVWF  CountReg 
        RETURN

; -------------------------
; Display Subroutines 9–0 (Down Counting)
; -------------------------


; -------------------------
; Delay Subroutine
; -------------------------

ClearDisplay:
    MOVLW b'11111111'
    MOVWF PORTB
    CALL RunDelaySh
	RETURN



RunDelaySh:
    MOVLW 0xFF
    MOVWF OuterDelay
OuterLoopSh:
    MOVLW 0xFF
    MOVWF InnerDelay
InnerLoopSh:
    NOP
    DECFSZ InnerDelay, 1
    GOTO InnerLoopSh
    DECFSZ OuterDelay, 1
    GOTO OuterLoopSh
    RETURN

RunDelaySh2:
    MOVLW 0xFF
    MOVWF OuterDelay
OuterLoopSh2:
    MOVLW 0xFF
    MOVWF InnerDelay
InnerLoopSh2:
    NOP
    DECFSZ InnerDelay, 1
    GOTO InnerLoopSh2
    DECFSZ OuterDelay, 1
    GOTO OuterLoopSh2

    RETURN






RunDelay:
    MOVLW 0xFF
    MOVWF OuterDelay
OuterLoop:
    MOVLW 0xFF
    MOVWF InnerDelay
InnerLoop:
    NOP
    DECFSZ InnerDelay, 1
    GOTO InnerLoop
    DECFSZ OuterDelay, 1
    GOTO OuterLoop

	CALL RunDelaySh
	CALL RunDelaySh
	CALL RunDelaySh
	MOVLW 0X00
    
    RETURN



; -------------------------
; Button Check Routine
; -------------------------



ReadButton:
    CLRF TempStorage2
    BTFSS PORTA, 6        ; Check if button is pressed (RA6 = 0 when pressed)
    BSF TempStorage2, 0
    MOVFW TempStorage2
    MOVWF BtnState
    RETURN

ChangeDir:

    BTFSC ButtonDown,0
    Return
    BTFSS Dir,0
    GOTO SetBit
    CLRF Dir
    RETURN

SetBit:
    BSF Dir,0
    RETURN
ReadButtonClick:
    CLRF ButtonDown
    BTFSS PORTA, 5       ; Check if button is pressed (RA6 = 0 when pressed)
    BSF ButtonDown , 0
    
StillDown:
    BTFSS PORTA, 5	
    Goto buttonUp
    Goto StillDown

ButtonUp:
    CALL ChangeDir
      

    RETURN


END
