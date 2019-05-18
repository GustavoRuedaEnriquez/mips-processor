.text
addi $t0,$zero,8
jal loop
addi $t0,$zero,16
j exit

loop:
addi $t0,$zero,7
jr $ra
exit: