DATA    SEGMENT
ANS     DB 9 DUP(?)
NUM     DB 0
DATA    ENDS

CODE    SEGMENT
        ASSUME CS:CODE,DS:DATA

MAIN    PROC FAR
        
        PUSH DS
        SUB AX,AX
        PUSH AX

        MOV AX,DATA
        MOV DS,AX
        
        MOV BL,1        ;BL=i
        CALL QUEEN
       
        MOV AH,0        ;to print the total number
        MOV AL,NUM
        MOV DL,10
        DIV DL
        MOV CX,AX
        OR CH,30H
        OR CL,30H
        MOV DL,CL       ;print the first number
        MOV AH,2
        INT 21H
        MOV DL,CH       ;print the second number
        MOV AH,2
        INT 21H
        RET
MAIN    ENDP

QUEEN   PROC NEAR
        CMP BL,8
        JA PRINTA
        MOV BH,0        ;BH=j
LOOPA:  INC BH
        CMP BH,8
        JA EXIT
        MOV CH,0        ;CH=k
LOOPB:  INC CH
        CMP CH,BL
        JAE NEXT
        MOV DH,0
        MOV DL,CH
        MOV SI,DX
        MOV CL,ANS[SI]  ;CL=ans[k]
        CMP CL,BH       
        JE NEXT
        MOV DL,BL
        SUB DL,CH       ;DL=i-k
        MOV DH,CL
        SUB DH,BH       ;DH=ans[k]-j
        CMP DH,0
        JGE COMP
        NEG DH          ;DH=|ans[k]-j|
COMP:   CMP DL,DH
        JE NEXT
        JMP LOOPB
NEXT:   CMP CH,BL
        JNE LOOPA
        MOV DH,0
        MOV DL,BL
        MOV SI,DX
        MOV ANS[SI],BH  ;ans[k]=j
        PUSH BX
        INC BL
        CALL QUEEN      ;go recursion
        POP BX
        JMP LOOPA
PRINTA: CALL PRINT
EXIT:   RET
QUEEN   ENDP

PRINT   PROC NEAR
        MOV CX,0
LOOPP:  INC CX
        CMP CX,8
        JA EXITP
        MOV SI,CX
        MOV DL,ANS[SI]  ;output number
        OR DL,30H
        MOV AH,2
        INT 21H
        MOV DL,20H      ;output space
        MOV AH,2
        INT 21H
        JMP LOOPP
EXITP:  INC NUM
        MOV DL,0AH      ;output \n
        MOV AH,2
        INT 21H
        RET
PRINT   ENDP

CODE    ENDS
        END MAIN