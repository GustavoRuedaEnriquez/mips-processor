.text
addi $s0,$zero,4

start:
addi $s0,$s0,-1
beq $s0,$zero,end
bne $s0,$zero,start

end:
add   $zero,$zero,$zero
add   $zero,$zero,$zero

