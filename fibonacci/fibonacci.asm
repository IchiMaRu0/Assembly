DATA    SEGMENT
RL      DW 0                ;lower part of the result
RH      DW 0                ;higher part of the result
DATA    ENDS

CODE    SEGMENT
        ASSUME CS:CODE,DS:DATA

MAIN    PROC FAR
START:  PUSH DS
        SUB AX,AX
        PUSH AX

        MOV AX,DATA
        MOV DS,AX

        MOV CH,0            ;CH=i
LOOPA:  INC CH              ;traverse from 1-30
        CMP CH,30
        JA EXIT
        MOV RH,0
        MOV RL,0
        CALL FIBO
        CALL PRINT
        JMP LOOPA
EXIT:   RET
MAIN    ENDP

PRINT   PROC NEAR
        MOV DX,RH           ;result/10000 in order to print it separately
        MOV AX,RL
        MOV BX,10000
        DIV BX              ;quotient in AX, remainder in DX
        PUSH DX             ;store the remainder
        MOV DL,10           ;print the first two numbers
        DIV DL              
        MOV BX,AX           
        OR BX,3030H
        MOV DL,BL
        MOV AH,2
        INT 21H
        MOV DL,BH
        INT 21H

        POP AX              ;get the remainder
        MOV DX,100          ;remainder/10
        DIV DL              ;quotient in AL, remainder in AH
        PUSH AX             ;store the remainder
        MOV AH,0
        MOV DL,10           ;print the next two numbers
        DIV DL              
        MOV BX,AX           
        OR BX,3030H
        MOV DL,BL
        MOV AH,2
        INT 21H
        MOV DL,BH
        INT 21H

        POP AX              ;get the remainder
        XCHG AL,AH
        MOV AH,0
        MOV DL,10           ;print the last two numbers
        DIV DL              
        MOV BX,AX           
        OR BX,3030H
        MOV DL,BL
        MOV AH,2
        INT 21H
        MOV DL,BH
        INT 21H

        MOV DL,0AH          ;print \n
        INT 21H
        RET
PRINT   ENDP

FIBO    PROC NEAR
BEGIN:  CMP CH,2            ;the first two results are 1
        JA RECU
        MOV RL,1
        MOV RH,0
        JMP EXITF
RECU:   DEC CH              ;get the last result
        CALL FIBO           ;recursion
        DEC CH
        PUSH RL             ;store the last result
        PUSH RH
        CALL FIBO           ;recursion
        POP BX
        POP DX
        ADD RL,DX           ;add the lower part
        ADC RH,BX           ;add the higher part, take CF into consideration
        INC CH
        INC CH
EXITF:  RET
FIBO    ENDP

CODE    ENDS
        END MAIN