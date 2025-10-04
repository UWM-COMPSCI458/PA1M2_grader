# Echo input integer with pseudoinstructions
# 35 points

.data
prompt:  .asciiz "Enter an integer less than 1,193,046: "
error:   .asciiz "Your integer is not less than 1,193,046\n"
echo:    .asciiz "You entered the number "
newline: .asciiz "\n"

.text

        # Prompt user for input
        #- li $v0, 4
        lui $at, 0x0000
        ori $v0, $at, 4
        #- la $a0, prompt
        lui $at, 0x1001
        ori $a0, $at, 0x0000 # I know prompt points to 0x10010000
        syscall

        # Get input from user
        #- li $v0, 5
        lui $at, 0x0000
        ori $v0, $at, 5
        syscall

        # Store input in $t0
        #- move $t0, $v0
        add $t0, $zero, $v0

        # Check to make sure input is less than 1,193,046
        #- li $t1, 0x0123456
        lui $at, 0x0012
        ori $t1, $at, 0x3456
        
        #- blt $t0, $t1, valid
        slt $at, $t0, $t1
        bne $at, $zero, valid
        j invalid
        
valid:
        ## Echo the number
        
        #- li $v0, 4
        lui $at, 0x0000
        ori $v0, $at, 4
        #- la $a0, echo
        lui $at, 0x1001
        ori $a0, $at, 0x0050 # I know echo points to 0x10010050
        syscall

        #- li $v0, 1
        lui $at, 0x0000
        ori $v0, $at, 1
        #- move $a0, $t0
        add $a0, $zero, $t0
        syscall

        #- li $v0, 4
        lui $at, 0x0000
        ori $v0, $at, 4
        #- la $a0, newline
        lui $at, 0x1001
        ori $a0, $at, 0x0068 # I know newline points to 0x10010068
        syscall

        j finished
        
invalid:
        # Print an invalid input statement
        #- li $v0, 4
        lui $at, 0x0000
        ori $v0, $at, 4
        #- la $a0, error
        lui $at, 0x1001
        ori $a0, $at, 0x0027 # I know error points to 0x10010027
        syscall


finished:
        # Exit cleanly
        #- li $v0, 10
        lui $at, 0x0000
        ori $v0, $at, 10
        syscall
        
