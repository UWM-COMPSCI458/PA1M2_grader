# Echo input integer with pseudoinstructions
# 35 points

.data
prompt:  .asciiz "Enter an integer less than 1,193,046: "
error:   .asciiz "Your integer is not less than 1,193,046\n"
echo:    .asciiz "You entered the number "
newline: .asciiz "\n"

.text

        # Prompt user for input
        li $v0, 4
        la $a0, prompt
        syscall

        # Get input from user
        li $v0, 5
        syscall

        # Store input in $t0
        move $t0, $v0

        # Check to make sure input is less than 1,193,046
        li $t1, 0x0123456
        blt $t0, $t1, valid
        j invalid
        
valid:
        ## Echo the number
        
        li $v0, 4
        la $a0, echo
        syscall

        li $v0, 1
        move $a0, $t0
        syscall

        li $v0, 4
        la $a0, newline
        syscall

        j finished
        
invalid:
        # Print an invalid input statement
        li $v0, 4
        la $a0, error
        syscall


finished:
        # Exit cleanly
        li $v0, 10
        syscall
        
