	.data
	
	str1: .asciiz "LageR"
	str2: .asciiz "Regal"
	str3: .space 10		#leere Byte
		.byte 0xff
		.byte 0xff
	
	
	.text
	.globl main
	
main:
	
	addi $12, $0, 65	#A Konstante;
	addi $13, $0, 90	#Z Konstante;
	
	lui $4, 0x1001
	ori $4, $4, 0x0000
	jal strtolower
	
	
	lui $4, 0x1001
	ori $4, $4, 0x0006
	jal strtolower

	
	syscall		#Ende

strtolower:

loop:
	lb $8, 0($4)		#Load Byte on 0; aka letter 
	
	beq $8, $0, end		#check if empty
	
	slt $10, $8, $13 	# letter < Z
	beq $10, $0, skip	# if yes then no uppercase letter in ascii
	
	slt $11, $12, $8	# letter > A
	beq $11, $0, skip	# if yes then def uppercase letter in ascii
	
	addi $8, $8, 32		#+32 for lowercase in asci;
	
	sb $8, 0($a0)		# store Byte an die adressen
		
skip:
	addi $4, $4, 1		# next letter in Word ( nochmal checken )
	j loop
	
end:
	jr $ra
	