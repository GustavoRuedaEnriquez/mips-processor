.text
addi  $t0,$zero,5
add   $t1,$t0,$zero
addi  $t1,$t1,2
addi  $t2,$t1,3
addi  $t3,$t3,0x01001
sll   $t3,$t3,16
sw    $t2,0($t3)
add   $zero,$zero,$zero
add   $s0,$t2,$t1
sub   $s1,$s0,$t3
lw    $t2,0($t3)
add   $zero,$zero,$zero
addi  $s2,$t2,-2
or    $s2,$s2,$t4
sll   $s7,$s2,2
add   $zero,$zero,$zero
add   $zero,$zero,$zero

exit: 