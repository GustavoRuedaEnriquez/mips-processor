.text
addi $t0,$t0,5
label:
addi $t0,$t0,-1
add $zero,$zero,$zero
add $zero,$zero,$zero
bne $t0,1, label
addi $t0,$zero,8
add $zero,$zero,$zero
add $zero,$zero,$zero