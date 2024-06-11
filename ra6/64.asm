	.data
	
	str1: .asciiz "LageL"
	str2: .asciiz "Regal"
	str3: .space 10		#leere Byte
		.byte 0xff
		.byte 0xff
	.text
	
	lui $4, 0x1001
	ori $4, $4, 0
	
	jal strcat
	syscall
	
strcat:
	lb $8, 0($4)
	beq $8, $0, continue
	addi $4, $4, 1
	j strcat
	
continue:
	sub $4, $4, 1
	lb $8, 0($4)
	

	
	
deadstop:
	jr $ra