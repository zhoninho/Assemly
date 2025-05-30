; Lab 5, Task 2
; Student: Bakirov Zhanat
; Group: EPI 4-23

    AREA TASK, CODE, READONLY
    ENTRY

START
    MOV R1, #4              ; R1 = the number to calculate factorial of (4!)
    MOV R0, #1              ; R0 = result of factorial, initially 1
    BL CALCULATE_FACTORIAL  ; Branch to subroutine to compute factorial
    B STOP                  ; Infinite loop after calculation ends

; Subroutine to calculate factorial of number in R1
CALCULATE_FACTORIAL
    MOV R4, LR              ; Save return address (link register)
    CMP R1, #1              ; Check if R1 <= 1 (base case)
    BLE FACTORIAL_DONE      ; If R1 is 1 or less, we're done

    MOV R2, R0              ; Store current result in R2
    MUL R0, R2, R1          ; Multiply result by current number
    SUB R1, R1, #1          ; Decrease number by 1
    B CALCULATE_FACTORIAL   ; Repeat loop

FACTORIAL_DONE
    MOV LR, R4              ; Restore return address
    BX LR                   ; Return from subroutine

STOP
    B STOP                  

    END
