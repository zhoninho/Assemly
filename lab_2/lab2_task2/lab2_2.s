; Lab 2, Task 2
; Student: Bakirov Zhanat
; Group: EPI 4-23

    AREA SUM_POS_NEG, CODE, READONLY   
    ENTRY                              

    LDR R0, =NUMBERS       ; R0 points to the start of the number array
    LDR R1, =POS_SUM       ; R1 points to the memory location for positive count
    LDR R2, =NEG_SUM       ; R2 points to the memory location for negative count

    LDR R3, [R1]           ; R3 = current count of positive numbers (initially 0)
    LDR R4, [R2]           ; R4 = current count of negative numbers (initially 0)

    BL ProcessNumbers      ; Branch with link to subroutine to process numbers
    B STOP                 ; Infinite loop to end the program safely

STOP B STOP                ; Infinite loop 

AddToNegative
    ADD R4, R4, #1         ; Increment negative count by 1
    B ProcessNumbers       ; Continue processing the next number

AddToPositive
    ADD R3, R3, #1         ; Increment positive count by 1
    B ProcessNumbers       ; Continue processing the next number

StopProcessing
    STR R3, [R1]           ; Store final positive count into memory
    STR R4, [R2]           ; Store final negative count into memory
    BX LR                  ; Return from subroutine

ProcessNumbers
    LDR R5, [R0], #4       ; Load current number into R5 and increment R0 to next number
    CMP R5, #0             ; Check if the number is zero
    BEQ StopProcessing     ; If zero, stop processing
    BLT AddToNegative      ; If number is less than zero, go to AddToNegative
    BGT AddToPositive      ; If number is greater than zero, go to AddToPositive

    AREA SUM_POS_NEG, DATA, READWRITE  
    ALIGN                             

NUMBERS  DCD 20, -8, -35, 10, 15, -7, 0 
POS_SUM  DCD 0                         
NEG_SUM  DCD 0                         

    END                                
