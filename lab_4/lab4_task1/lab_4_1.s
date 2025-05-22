; Lab 4, Task 1
; Student: Bakirov Zhanat
; Group: EPI 4-23

    AREA Lab4Task1, CODE, READONLY
    ENTRY
    MOV R0, #0              ; R0 = sum
    LDR R1, =ARRAY_POINTER  ; R1 = pointer to the array NUM1
    LDR R1, [R1]            ; R1 = actual address of NUM1
    LDR R2, =COUNT_N        ; R2 = pointer to N (count)
    LDR R2, [R2]            ; R2 = value of N (actual count)

    BL  ProcessingLoop      ; Call the main processing loop
    B   Stop

ProcessingLoop
    LDR R3, [R1], #4        ; Load number from [R1] into R3, then R1 = R1 + 4 (post-indexed)

    CMP R3, #5              ; Compare loaded number R3 with 5
    BGT AddNumber           ; If R3 > 5, branch to add it

CheckNextNumber
    SUBS R2, R2, #1         ; Decrement loop counter (N) and update flags
    BGT ProcessingLoop      ; If N > 0, continue loop

    LDR R4, =SUM_RESULT_PTR ; R4 = pointer to (address of) SUM storage
    LDR R4, [R4]            ; R4 = actual address of SUM storage
    STR R0, [R4]            ; Store the final sum (R0) into memory
    BX  LR                  ; Return from subroutine (ProcessingLoop)

AddNumber
    ADD R0, R0, R3          ; Add R3 to sum 
    B   CheckNextNumber     ; Go back to check/decrement counter

Stop    B   Stop

    AREA Lab4Task1, DATA, READWRITE
    ALIGN

SUM_RESULT        DCD 0
SUM_RESULT_PTR    DCD SUM_RESULT
COUNT_N           DCD 7
ARRAY_NUMS        DCD 3, -7, 2, -2, 10, 20, 30
ARRAY_POINTER     DCD ARRAY_NUMS

    END