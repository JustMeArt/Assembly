	.data
	
	str1: .asciiz "LageR"
	str2: .asciiz "Regal"
	str3: .space 10		#leere Byte
		.byte 0xff
		.byte 0xff
		
	.text
main:
	
	lui $4, 0x1001
	ori $4, $4, 0x0000
	jal strtolower

	lui $4, 0x1001
	ori $4, $4, 0x0006
	jal strtolower
####################################
	addi $1, $0, 1
	
	lui $a0, 0x1001
	ori $a0, $a0, 0x0000
	add $8, $0, $a0
	
	jal strturnaround
	#str2:
	
	lui $a0, 0x1001
	ori $a0, $a0, 0x0006
	add $8, $0, $a0
	
	jal strturnaround
	
	syscall

strtolower:

	addi $12, $0, 65	#A Konstante;
	addi $13, $0, 90	#Z Konstante;

loop1:
	lb $8, 0($4)		#Load Byte on 0; aka letter 
	
	beq $8, $0, end1		#check if empty
	
	slt $10, $8, $13 	# letter < Z
	beq $10, $0, skip	# if yes then no uppercase letter in ascii
	
	slt $11, $12, $8	# letter > A
	beq $11, $0, skip	# if yes then def uppercase letter in ascii
	
	addi $8, $8, 32		#+32 for lowercase in asci;
	
	sb $8, 0($a0)		# store Byte an die adressen
		
skip:
	addi $4, $4, 1		# next letter in Word ( nochmal checken )
	j loop1
	
end1:
	jr $ra
	
###########################################

strturnaround:
	lb $9, 0($8)
	beq $9, $0, duck
	
	addi $8, $8, 1
	j strturnaround
	
duck:
	bge $a0, $8, end2
	sub, $8, $8, $1 	# letzte position vom wort
	lb $10, 0($a0)
	lb $11, 0($8)
	
	sb $10, 0($8)
	sb $11, 0($a0)
	addi $a0, $a0, 1
	#sub $8, $8, $1
	
	j duck
	
end2:
	jr $ra
