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
    MOVLW b'11111110'       
    MOVWF TRISA             ; Set RA6 as input for button
    BCF STATUS, RP0         ; Back to Bank 0

    CLRF PORTB              ; Clear display port
    CLRF PORTA              ; Clear input port

MainLoop:

    ; Counting from 0 to 9
    CALL Display0
    CALL Display1
    CALL Display2
    CALL Display3
    CALL Display4
    CALL Display5
    CALL Display6
    CALL Display7
    CALL Display8
    CALL Display9

    ; Counting from 9 back to 0
    CALL Display9Rev
    CALL Display8Rev
    CALL Display7Rev
    CALL Display6Rev
    CALL Display5Rev
    CALL Display4Rev
    CALL Display3Rev
    CALL Display2Rev
    CALL Display1Rev
    CALL Display0Rev

    GOTO MainLoop

; -------------------------
; Display Subroutines 0–9 (Up Counting)
; -------------------------

Display0:
    CALL ReadButton
    MOVLW b'11000000'
    MOVWF PORTB
    CALL RunDelay
    BTFSC BtnState, 0
    GOTO Display0
    RETURN

Display1:
    CALL ReadButton
    MOVLW b'11111001'
    MOVWF PORTB
    CALL RunDelay
    BTFSC BtnState, 0
    GOTO Display1
    RETURN

Display2:
    CALL ReadButton
    MOVLW b'10100100'
    MOVWF PORTB
    CALL RunDelay
    BTFSC BtnState, 0
    GOTO Display2
    RETURN

Display3:
    CALL ReadButton
    MOVLW b'10110000'
    MOVWF PORTB
    CALL RunDelay
    BTFSC BtnState, 0
    GOTO Display3
    RETURN

Display4:
    CALL ReadButton
    MOVLW b'10011001'
    MOVWF PORTB
    CALL RunDelay
    BTFSC BtnState, 0
    GOTO Display4
    RETURN

Display5:
    CALL ReadButton
    MOVLW b'10010010'
    MOVWF PORTB
    CALL RunDelay
    BTFSC BtnState, 0
    GOTO Display5
    RETURN

Display6:
    CALL ReadButton
    MOVLW b'10000010'
    MOVWF PORTB
    CALL RunDelay
    BTFSC BtnState, 0
    GOTO Display6
    RETURN

Display7:
    CALL ReadButton
    MOVLW b'11111000'
    MOVWF PORTB
    CALL RunDelay
    BTFSC BtnState, 0
    GOTO Display7
    RETURN

Display8:
    CALL ReadButton
    MOVLW b'10000000'
    MOVWF PORTB
    CALL RunDelay
    BTFSC BtnState, 0
    GOTO Display8
    RETURN

Display9:
    CALL ReadButton
    MOVLW b'10010000'
    MOVWF PORTB
    CALL RunDelay
    BTFSC BtnState, 0
    GOTO Display9
    RETURN

; -------------------------
; Display Subroutines 9–0 (Down Counting)
; -------------------------

Display9Rev:
    CALL Display9
    RETURN

Display8Rev:
    CALL Display8
    RETURN

Display7Rev:
    CALL Display7
    RETURN

Display6Rev:
    CALL Display6
    RETURN

Display5Rev:
    CALL Display5
    RETURN

Display4Rev:
    CALL Display4
    RETURN

Display3Rev:
    CALL Display3
    RETURN

Display2Rev:
    CALL Display2
    RETURN

Display1Rev:
    CALL Display1
    RETURN

Display0Rev:
    CALL Display0
    RETURN

; -------------------------
; Delay Subroutine
; -------------------------

RunDelay:
    MOVLW 0x2a
    MOVWF OuterDelay
OuterLoop:
    MOVLW 0xff
    MOVWF InnerDelay
InnerLoop:
    NOP
    DECFSZ InnerDelay, 1
    GOTO InnerLoop
    DECFSZ OuterDelay, 1
    GOTO OuterLoop
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

END
