.data
str1: .asciiz "Lager"
str2: .asciiz "Regal"

.text
.globl main

# Function: strtolower
# Converts all uppercase letters in a string to lowercase.
# Arguments: $a0 - address of the string

strtolower:
    # Loop through each character in the string
    loop:
        lb $t0, 0($a0)        # Load the current character from the string
        beqz $t0, end_loop    # If character is null terminator, end loop

        # Check if the character is uppercase (between 'A' and 'Z')
        li $t1, 65            # Load ASCII value of 'A' into $t1
        li $t2, 90            # Load ASCII value of 'Z' into $t2
        blt $t0, $t1, not_uppercase  # If character < 'A', skip to next character
        bgt $t0, $t2, not_uppercase  # If character > 'Z', skip to next character

        # Convert uppercase to lowercase by adding 32
        addi $t0, $t0, 32     # Add 32 to the character to convert to lowercase
        sb $t0, 0($a0)        # Store the converted character back to the string

        not_uppercase:
        addi $a0, $a0, 1      # Move to the next character in the string
        j loop                # Repeat the loop

    end_loop:
        jr $ra                # Return from the function

main:
    la $a0, str1              # Load address of str1 into $a0
    jal strtolower            # Call strtolower function

    la $a0, str2              # Load address of str2 into $a0
    jal strtolower            # Call strtolower function

    # Exit program
    li $v0, 10                # Load the exit syscall code into $v0
    syscall                   # Make the syscall
