.text
addi $t0,$zero,5

add $zero,$zero,$zero
add $zero,$zero,$zero

add $t1,$t0,$zero

add $zero,$zero,$zero
add $zero,$zero,$zero

addi $t1,$t1,2

add $zero,$zero,$zero
add $zero,$zero,$zero


addi $t2,$t1,3

add $zero,$zero,$zero
add $zero,$zero,$zero

addi $t3,$t3,0x01001

add $zero,$zero,$zero
add $zero,$zero,$zero

sll $t3,$t3,16

add $zero,$zero,$zero
add $zero,$zero,$zero

sw $t2,0($t3)

add $zero,$zero,$zero
add $zero,$zero,$zero
add $zero,$zero,$zero

add $s0,$t2,$t1

add $zero,$zero,$zero
add $zero,$zero,$zero

sub $s1,$s0,$t3

add $zero,$zero,$zero
add $zero,$zero,$zero

lw $t2,0($t3)

add $zero,$zero,$zero
add $zero,$zero,$zero
add $zero,$zero,$zero

addi $s2,$t2,-2

add $zero,$zero,$zero
add $zero,$zero,$zero

or $s2,$s2,$t4

add $zero,$zero,$zero
add $zero,$zero,$zero

sll $s7,$s2,2
add $zero,$zero,$zero
add $zero,$zero,$zero
exit: