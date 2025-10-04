# No data, no pseudoinstructions, no labels
# 10 points
.data

.text
        add $1, $2, $3
        addiu $4, $5, -123
        and $6, $7, $8
        andi $9, $10, 4200
        lui $11, 0x123
        lw $12, 42($13)
        or $14, $15, $16
        ori $17, $18, 0xE9D2
        slt $19, $20, $21
        sub $22, $23, $24
        sw $25, 0($26)
        syscall
