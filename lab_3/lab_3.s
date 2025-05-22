; Lab 3
; Student: Bakirov Zhanat
; Group: EPI 4-23
	
	AREA LAB3, CODE, READONLY       
    ENTRY                           

    ADR R0, STRING                  ; Load address of the string into R0
    MOV R1, #0                      ; R1 = vowel count
    MOV R2, #0                      ; R2 = other characters count (excluding ' ' and '!')

    BL LOOP                         ; Call main loop
    B STOP                          ; End of program

; Main loop to process each character
LOOP    
    LDRB R3, [R0], #1               ; Load next character from string into R3, increment R0
    CMP R3, #0                      ; Check for end of string 
    BEQ END_LOOP                    ; If end, exit loop

    MOV R4, LR                      ; Save return address before calling subroutine
    BL CHECK_FOR_VOWEL             ; Check if the character is a vowel
    MOV LR, R4                      ; Restore return address

    MOV R4, LR                      ; Save return address again
    BL CHECK_FOR_SIGNS             ; Check if the character is a space or !
    MOV LR, R4                      ; Restore return address

    ADD R2, R2, #1                  ; If not a vowel or skipped sign, count as other
    B LOOP                          ; Repeat loop for next character

; End of loop — return from the main function
END_LOOP
    BX LR                           ; Return to caller

CHECK_FOR_SIGNS
    CMP R3, #' '                    ; Is it a space?
    BEQ IS_SIGN
    CMP R3, #'!'                    ; Is it an exclamation mark?
    BEQ IS_SIGN
    BX LR                           ; Not a sign — return

IS_SIGN
    MOV LR, R4                      ; Restore LR from saved value
    B LOOP                          ; Go back to main loop (skip counting this character)

; Subroutine: Check if character is a vowel (uppercase or lowercase)
CHECK_FOR_VOWEL
    CMP R3, #'A'
    BEQ IS_VOWEL
    CMP R3, #'E'
    BEQ IS_VOWEL
    CMP R3, #'I'
    BEQ IS_VOWEL
    CMP R3, #'O'
    BEQ IS_VOWEL
    CMP R3, #'U'
    BEQ IS_VOWEL
    CMP R3, #'Y'
    BEQ IS_VOWEL
    CMP R3, #'a'
    BEQ IS_VOWEL
    CMP R3, #'e'
    BEQ IS_VOWEL
    CMP R3, #'i'
    BEQ IS_VOWEL
    CMP R3, #'o'
    BEQ IS_VOWEL
    CMP R3, #'u'
    BEQ IS_VOWEL
    CMP R3, #'y'
    BEQ IS_VOWEL
    BX LR                           ; Not a vowel — return

IS_VOWEL
    MOV LR, R4                      ; Restore LR from saved value
    ADD R1, R1, #1                  ; Increment vowel count
    B LOOP                          ; Go back to main loop


STOP
    B STOP


    AREA LAB3, DATA, READWRITE     

STRING 
    DCB "ARM assembly language is important to learn!", 0 

    END
