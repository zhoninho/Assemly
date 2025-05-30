; Lab 4, Task 2
; Student: Bakirov Zhanat
; Group: EPI 4-23

    AREA MYCODE, CODE, READONLY   
    ENTRY                         

    LDR R1, POINTER               ; Load address of the array NUM1 into R1
    LDR R2, N                     ; Load the number of elements in the array into R2 (12)

    LDR R3, [R1]                  ; Load the first element of the array into R3 (initial min)
    LDR R4, [R1]                  ; Load the first element of the array into R4 (initial max)

    BL LOOP                       ; Branch to LOOP subroutine to find min and max

    LDR R6, MaxP                  ; Load address of Max variable into R6
    STR R4, [R6]                  ; Store maximum value (R4) into Max

    LDR R6, MinP                  ; Load address of Min variable into R6
    STR R3, [R6]                  ; Store minimum value (R3) into Min

    B STOP                        ; Infinite loop to stop the program
	

LOOP
    LDR R5, [R1], #4              ; Load next array element into R5 and increment R1 by 4 bytes

    CMP R5, R3                    ; Compare R5 with current minimum (R3)
    BGT SAVE_MAX                  ; If R5 > R3, maybe it's the max ? branch to SAVE_MAX

    CMP R5, R3                    ; Compare R5 with current minimum again
    BLT SAVE_MIN                  ; If R5 < R3 ? branch to SAVE_MIN

    SUBS R2, R2, #1               ; Decrease counter R2
    BGT LOOP                      ; If more elements left ? repeat loop

    BX LR                         ; Return from subroutine

SAVE_MAX
    MOV R4, R5                    ; Move new max value into R4
    SUBS R2, R2, #1               ; Decrement counter
    BGT LOOP                      ; Repeat if more elements
    BX LR                         ; Return if done

; ===== Save new minimum value =====

SAVE_MIN
    MOV R3, R5                    ; Move new min value into R3
    SUBS R2, R2, #1               ; Decrement counter
    BGT LOOP                      ; Repeat if more elements
    BX LR                         ; Return if done

STOP B STOP                       

    AREA MYCODE, CODE, READWRITE 

Max     DCD 0                    
MaxP    DCD Max                

Min     DCD 0                    
MinP    DCD Min                 

N       DCD 12                   

NUM1    DCD 3, -7, 2, -2, 10, 20, 30, 15, 32, 8, 64, 66 

POINTER DCD NUM1               
    END                          
