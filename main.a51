Start:
      MOV TMOD,  #01H
      MOV P1,#00H    ; OUTPUT
      MOV R0, #64H
      
Loop:
    ACALL PWM
    jmp Loop

PWM:
    MOV A,#0FFH ; 255
    SUBB A,R0
    SETB P1.0
    ACALL DELAY_A
    MOV A, R0
    CLR P1.0
    ACALL DELAY_A
    ACALL LOOP
DELAY_A:
    MOV TL0, A
    MOV TH0, #0FFH
    SETB TR0
    HERE: JNB TF0, HERE
    CLR TF0
    CLR TR0
    RET
END
