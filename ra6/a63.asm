	.data
	
	str1: .asciiz "LageL"
	str2: .asciiz "Regal"
	str3: .space 10		#leere Byte
		.byte 0xff
		.byte 0xff
		
	.text
main:
	lui $4, 0x1001
	ori $4, $4, 0
	add $5, $4, $0
	jal strispalindrom
	
	syscall
	
strispalindrom:
	lb $9, 0($5)
	beq $9, $0, empty
	
palindrom:
	lb $9, 0($5)
	beq $9, $0, back
	addi $5, $5, 1
	j palindrom
back:
	sub $5, $5, 1
back_next:

	lb $8, 0($4)
	lb $9, 0($5)
	beq $8, $9, is_palindrom
	j end3
	
is_palindrom:
	addi $4, $4, 1
	j back
	#addi $1,$0, 10
end3:
	jr $ra
empty:
	jr $ra