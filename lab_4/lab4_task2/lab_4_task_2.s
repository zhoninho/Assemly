; Lab 4, Task 2
; Student: Bakirov Zhanat
; Group: EPI 4-23

        AREA MYCODE, CODE, READONLY
        ENTRY
        MOV R0, #0          ; R0 will hold the total sum of numbers > 5
        LDR R1, POINTER     ; R1 = address of the array NUM1
        LDR R2, N           ; R2 = number of elements in the array (N = 7)
        BL LOOP1            ; Branch to the LOOP1 subroutine
        B STOP              

LOOP1
        LDR R3, [R1], #4    ; Load next number from array into R3, increment R1 to next element
        CMP R3, #5          ; Compare the number with 5
        BGT ADDSUM          ; If number > 5, branch to ADDSUM (add it to sum)
        SUBS R2, R2, #1     ; Otherwise, decrease counter (R2) by 1
        BGT LOOP1            ; If there are more elements, continue loop
        ; If loop is done, store the result
        LDR R4, SUMP        ; Load address of variable SUM into R4
        STR R0, [R4]        ; Store final result (R0) into memory at address SUM
        BX LR               ; Return from subroutine

ADDSUM
        ADD R0, R0, R3      ; Add R3 (current number) to R0 (sum)
        SUBS R2, R2, #1     ; Decrease counter by 1
        BGT LOOP1            ; If more elements left, repeat loop
        ; If loop is done, store the result
        LDR R4, SUMP        ; Load address of SUM
        STR R0, [R4]        ; Store final result
        BX LR               ; Return from subroutine
STOP    
        B STOP

        AREA MYCODE, DATA, READWRITE

SUM     DCD     0           
SUMP    DCD     SUM        
N       DCD     7           
NUM1    DCD     3, -7, 2, -2, 10, 20, 30 
POINTER DCD     NUM1       

        END					; End of the program 
