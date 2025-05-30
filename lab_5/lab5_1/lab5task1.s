    AREA LAB5, CODE, READONLY
    ENTRY

      LDR   R0, =STRING      ; Loading the address of the string into R0
      BL    strlen           ; Call strlen to calculate the string length (R1)

      MOV   R2, #0           ; Initialize vowel counter R2 = 0
      LDR   R0, =STRING      ; Reset R0 to the beginning of the string (for replay)

LOOP
      LDRB  R3, [R0], #1     ; Load current symbol into R3 and increase pointer by 1
      BL    check_vowel      ; Call isvowel to check if symbol is a vowel (R4)

      CMP   R4, #1           ; If R4 (the result indicates) is a vowel
      ADDEQ R2, R2, #1       ; If it is a vowel, increment the vowel counter by 1

      SUBS  R1, R1, #1       ; Decrease remaining symbol count by 1
      BGT   LOOP             ; Repeat the loop if there are any symbols left

STOP
      B     STOP             ; Infinite loop to halt the program


strlen PROC
      MOV   R1, #0           ; Initialize length counter in R1 = 0

strlen_loop
      LDRB  R3, [R0], #1     ; Load next byte into R3 and increment pointer by 1
      CMP   R3, #0           ; Compare with null
      BEQ   strlen_end       ; If so, end the loop
      ADD   R1, R1, #1       ; If R3 isn't null, increment length counter by 1
      B     strlen_loop      ; Repeat the loop

strlen_end
      BX    LR               ; Return to caller
      ENDP


check_vowel PROC
      PUSH  {R2}             ; Save R2 on the stack
      LDR   R5, =VOWELS      ; Load the address of the vowel list into R5
      MOV   R4, #0           ; Default result is 0 (not a vowel)

check_next
      LDRB  R6, [R5], #1     ; Load next vowel character into R6 and increment R5 by 1
      CMP   R6, #0           ; Check for end of vowel list
      BEQ   vowel_end        ; If end reached
      CMP   R3, R6           ; Compare input character with current vowel
      BEQ   vowel_true       ; If match, it's a vowel
      B     check_next       ; if not, check next character

vowel_true
      MOV   R4, #1           ; Set result to 1

vowel_end
      POP   {R2}             ; Restore R2 from the stack
      BX    LR               ; Return to caller
      ENDP

    AREA LAB5, DATA, READWRITE

STRING
      DCB   "Almost every ARM instruction has a conditional execution feature called predication, which is implemented with a 4-bit condition code selector!", 0

VOWELS
      DCB   "AaEeIiOoUuYy", 0     ; list of vowel characters
      ALIGN

INITIAL_MSP  EQU   0x20001000   ; Define initial Main Stack Pointer value
Vectors      DCD   INITIAL_MSP  ; Stack pointer value at reset

    END
