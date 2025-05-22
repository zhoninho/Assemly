; Lab 5, Task 1
; Student: Bakirov Zhanat
; Group: EPI 4-23

	AREA Lab5Task1, CODE, READONLY
    ENTRY
START_CODE
    ADR R0, STRING
    BL STRING_LENGTH    ; Get string length in R1
    ADR R0, STRING      ; Reset pointer to string
    MOV R2, #0          ; Initialize vowel counter
    BL COUNT_VOWELS     ; Call vowel counting routine
    B STOP

COUNT_VOWELS
    PUSH {R4, LR}       ; Save registers including link register
    
VOWEL_LOOP
    LDRB R3, [R0], #1   ; Load next character
    CMP R3, #0          ; Check for null terminator
    BEQ END_COUNT       ; If null, end counting
    
    BL CHECK_FOR_VOWEL  ; Check if current character is vowel
    B VOWEL_LOOP        ; Continue loop
    
END_COUNT
    POP {R4, LR}        ; Restore registers
    BX LR               ; Return to caller
    
CHECK_FOR_VOWEL
    PUSH {LR}           ; Save link register
    
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
    
    POP {LR}            ; Restore link register
    BX LR               ; Return to caller
    
IS_VOWEL
    ADD R2, R2, #1      ; Increment vowel counter
    POP {LR}            ; Restore link register
    BX LR               ; Return to caller
  
STOP 
    B STOP              ; Infinite loop
    
STRING_LENGTH 
    PUSH {R4, LR}       ; Save registers
    MOV R1, #0          ; Initialize length counter
    
STRING_LOOP
    LDRB R4, [R0], #1   ; Load next character
    CMP R4, #0          ; Check for null terminator
    BEQ STRING_ENDED    ; If null, end counting
    ADD R1, R1, #1      ; Increment length counter
    B STRING_LOOP       ; Continue loop
    
STRING_ENDED
    POP {R4, LR}        ; Restore registers
    BX LR               ; Return to caller
    
    AREA Lab5Task1, DATA, READWRITE
    
STRING
    DCB "Almost every ARM instruction has a conditional execution feature called predication, which is implemented with a 4-bit condition code selector!", 0
    END