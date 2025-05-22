; Lab 2, Task 1
; Student: Bakirov Zhanat
; Group: EPI 4-23

    AREA Lab2Task1, CODE, READONLY
    ENTRY

    MOV R10, #32        ; Constant 32
    MOV R11, #9         ; Constant 9
    MOV R12, #5         ; Constant 5

    ; R9 is the numerator, R8 is the denominator for division, R7 is the result (quotient)

    MOV R0, #95         ; Input: F = 95 (Fahrenheit)

    ; Calculation: C = (F - 32) * 5 / 9
    SUB R1, R0, R10     ; R1 = F - 32
    MUL R2, R1, R12     ; R2 = (F - 32) * 5

    MOV R9, R2          ; Numerator for division = R2
    MOV R8, R11         ; Denominator for division = 9
    BL  IntegerDivide   ; Call division subroutine. Result in R7
                        ; BL jumps to a subroutine, storing the return address in the LR register
    MOV R1, R7          ; Store Celsius result in R1. R1 = C

    ; Calculation: F = (C * 9 / 5) + 32
    MOV R2, #32         ; Input: C = 32 (Celsius)
    MUL R3, R2, R11     ; R3 = C * 9

    MOV R9, R3          ; Numerator for division = R3
    MOV R8, R12         ; Denominator for division = 5
    BL  IntegerDivide   ; Call division subroutine. Result in R7
    MOV R4, R7          ; R4 = (C * 9) / 5

    ADD R3, R4, R10     ; Final Fahrenheit result in R3 = R4 + 32
    B   Stop   ; Go to infinite loop

; Division Subroutine: divides R9 (numerator) by R8 (denominator), result in R7 (quotient)
IntegerDivide
    MOV R7, #0          ; Initialize quotient R7 to 0

DivisionLoop
    CMP R9, R8          ; Compare numerator R9 with denominator R8
    BLT EndDivision     ; If R9 < R8, division is complete (Branch if Less Than)

    SUB R9, R9, R8      ; R9 = R9 - R8 (subtract denominator from numerator)
    ADD R7, R7, #1      ; R7 = R7 + 1 (increment quotient)
    B   DivisionLoop    ; Repeat

EndDivision
    BX  LR              ; Return from subroutine (Branch and eXchange to Link Register)

Stop
    B   Stop   ; Infinite loop to stop the program

    END