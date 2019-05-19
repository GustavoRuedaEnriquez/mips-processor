.text
add $t0,$zero,$zero
label:
addi $t0,$t0,1
add $zero,$zero,$zero
add $zero,$zero,$zero
beq $t0,7,exit
j label
exit:
