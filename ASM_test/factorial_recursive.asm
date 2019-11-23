addui r1,r0,4		;N
addui r30,r0,0		;stack pointer
jal factorial
end_program:
j end_program

; parameter passed in r1, return value in r2

factorial:
seqi r2,r1,1			;set r2 if N is 1
bnez r2,end_factorial	;if r2 is set return 1, otherwise...
sw 0(r30),r31			;save link register on the stack
sw 4(r30),r1			;save N on the stack
addui r30,r30,8			;update stack pointer
addui r1,r1,-1			;compute N-1
jal factorial			;compute factorial(N-1)
lw r1,-4(r30)			;load N from the stack
lw r31,-8(r30)			;load link register from the stack
addui r30,r30,-8		;update stack pointer
mult r2,r2,r1			;compute N*factorial(N-1)
end_factorial:
jr r31
	