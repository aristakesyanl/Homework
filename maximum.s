.section .vector_table, "x"
.global _Reset
.data
 array:.byte 0x1,0x2,0x3,0x4,0x5,0x6,0x7,0x8
 size: .word 8
 

_Reset:
	B Reset_Handler
	B . /* 0x4 Undefined Instruction */
	B . /* 0x8 Software Interrupt */
	B . /* 0xC Prefetch Abort */
	B . /* 0x10 Data Abort */
	B . /* 0x14 Reserved */
	B . /* 0x18 IRQ */
	B . /* 0x1C FIQ */
.section .text
Reset_Handler:
   //load array address to r1 register
   LDRB r1,=array
   //load first value of array to r0
   //we will compare array value with r0
   //and stor the biggest one
   LDRB r0,[r1]
   LDR r3,=size
   //stor array size in r2 
   LDR r2,[r3]
   //push values of r1 and r2 so we can retriev them
   //after finishing the execution of our function
   PUSH {r1,r2}
   //branch with link
   //go to max_value function
   //and store the next instruction in lr register
   BL max_value
   //retrieve values of r1 and r2
   POP  {r1,r2}
   //go to end so we will jump the execution of max_value function once again
   B end
   
max_value:
   //stor the values of elements in r3 register 
   LDRB r3,[r1],#1
   //compare them with r0
   CMP r0,r3
   //if r0<r3 overwrite r0 with r3
   BLE greater

greater:
   MOV r0,r3
   //check that we have reached the end of function
   SUB r2,#1
   CMP r2, #0
   BEQ end_max
   BAL max_value
end_max: 
   BX lr
  
end:
   //hang
   B .
	
