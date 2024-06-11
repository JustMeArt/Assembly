	.data
	str1: .asciiz "LageR"
	str2: .asciiz "Regal"
	
	.text
main:
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
	
strturnaround:
	lb $9, 0($8)
	beq $9, $0, duck
	
	addi $8, $8, 1
	j strturnaround
	
duck:
	bge $a0, $8, end
	sub, $8, $8, $1 	# letzte position vom wort
	lb $10, 0($a0)
	lb $11, 0($8)
	
	sb $10, 0($8)y
	sb $11, 0($a0)
	addi $a0, $a0, 1
	#sub $8, $8, $1
	
	j duck
	
end:
	jr $ra
