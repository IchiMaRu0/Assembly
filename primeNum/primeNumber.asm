DATA    SEGMENT

DATA    ENDS

CODE    SEGMENT
        ASSUME CS:CODE,DS:DATA

MAIN    PROC FAR
BEGIN:  PUSH DS
        SUB AX,AX
        PUSH AX

        MOV AX,DATA
        MOV DS,AX

        MOV BH,2
LOOPA:  CMP BH,100      ;traverse from 1-100 in BH
        JA EXIT
        MOV BL,2
LOOPB:  CMP BL,BH       ;traverse from 2-BH in BL to see whether BH is prime
        JA NEXTA
        JE PRINT        ;all divisor checked. BH is prime and print it.
        MOV AH,0        ;BH/BL
        MOV AL,BH
        DIV BL
        CMP AH,0        ;BH%BL==0 ? BH isn't prime : check the next divisor
        JE NEXTA        ;check the next number
        JMP NEXTB       ;check the next divisor
PRINT:  MOV AH,0        ;pring number
        MOV AL,BH
        MOV DH,10
        DIV DH
        MOV CX,AX
        OR CH,30H
        OR CL,30H
        MOV DL,CL       ;print the first number
        MOV AH,2
        INT 21H
        MOV DL,CH       ;print the second number
        MOV AH,2
        INT 21H
        MOV DL,0AH      ;print \n
        MOV AH,2
        INT 21H
NEXTB:  INC BL          
        JMP LOOPB
NEXTA:  INC BH          
        JMP LOOPA
EXIT:   RET
MAIN    ENDP

CODE    ENDS
        END MAIN