# basic loops, no pseudoinstructions
# 25 points
.data

.text
        # Setup $t0 as loop counter and $t1 as loop end
        add $t0, $zero, $zero
        addiu $t1, $zero, 10
loop1:
        # Break out of loop if $t0 == $t1
        beq $t0, $t1, finished1

        # Otherwise increment $t0 and go back to top of loop
        addiu $t0, $t0, 1
        j loop1
        
finished1:

        # Setup $t2 a loop end, $t3 as loop counter and
        # $t4 as decrement value (subi not supported)
        add $t2, $zero, $zero
        addiu $t3, $zero, 21
        addiu $t4, $zero, 1

loop2:
        # Decrement $t3
        sub $t3, $t3, $t4

        # If $t2 != $t3, then go back to top of loop
        bne $t2, $t3, loop2

        # Otherwise exit cleanly
        addiu $v0, $zero, 10
        syscall
