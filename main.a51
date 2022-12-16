ORG 00H
LJMP MAIN
;-----interrup0_to_increase_speed--------------------------------------------------
    ORG 0003H
      CJNE A,#10,increase_speed
        AJMP max_SPEED
      increase_speed:
	 INC A
	 DEC B
      max_SPEED:
    RETI
;----interrupt1_to_decrease_speed--------------------------------------------
    ORG 0013H
      CJNE A,#0,decrease_speed
       AJMP MINIMUM_SPEED
      decrease_speed:
           DEC A
           INC B
      MINIMUM_SPEED:
    RETI
;-----timer_interrupt1_p2.0_for_emergency_stop-------------------------------------------
     ORG 001BH
      JNB P1.1,FINISH
        AJMP NULL
      FINISH:
	 SETB P1.0
	 JNB P1.1,FINISH
      NULL:
     RETI
;-----MAIN_PROGRAME--------------------------------------------------------------------------
   ORG 30H
    MAIN:
      MOV A,#0
      MOV B,#10
      SETB TCON.0
      SETB TCON.2
      MOV IE,#10001101B
      MOV TMOD,#00100001B
      MOV TH1,#0F0H
      SETB TR1
;-----MAIN_LOOP--------------------------------------------------------------------------
     HERE: 
	    CJNE A,#0,ON
	    AJMP HERE
        ON:
	CLR P1.0
	    MOV R0,A
	     L1: LCALL DELAY
	    DJNZ R0,L1
	  CJNE A,#10,L2
	   AJMP ON
	  L2: JC complete
	 complete:
	 SETB P1.0
	    MOV R0,B
	     L4: LCALL DELAY
	    DJNZ R0,L4 
      LJMP HERE
;-----TIMER0_DELAY--------------------------------------------------------------------------
      DELAY: 
	    MOV TL0,#33H
	    MOV TH0,#0FFH
	 SETB TR0
	 TARGET: JNB TF0,TARGET
	 CLR TR0
	 CLR TF0
      RET

END