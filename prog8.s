.global main
.fpu neon-fp-armv8
main:
	LDR R0, =prompt @ Load our R0 register with our prompt
	BL printf @ Branch and link to C standard library puts function
	LDR R0, =fmtIn @ Set our first argument for scanf into R0
	LDR R1, =buff @ Load our buffer into second argument for scanf
	BL scanf @ Branch and link to C standard library gets function
	LDR R1,=buff @ Load our buffer pointer into R1
	LDR R1,[R1] @ Load the value in our buffer into R1
	VMOV S0,R1 @ Move R1 into S0
	VCVT.f32.s32 S0,S0 @ Convert integer into floating point value
	BL convert @ Branch and link to our convert module
	BL taylorSeries @ Branch and link to our taylor series module
	@VCVT.s32.f32 S3,S3 @ Convert from floating point value back to integer
	LDR R0,=outPrompt @ Load R0 with our out prompt to print our result nicely
	BL printf @ Branch and link to C standard library printf function
	VMOV R0,S3 @ Move our final value into R0
	BL v_flt @ Branch and link to our v_flt module for printing
	MOV R0, #0 @ Service call for normal termination
	MOV R7, #1 @ Service call to terminate program
	SVC 0  @ Call linux service to terminate program

.data

.align 4

prompt: .asciz "Enter an angle in degrees: "
fmtIn: .string "%d"
buff: .space 100 
outPrompt: .asciz "The approximated sin value of your angle is: "
