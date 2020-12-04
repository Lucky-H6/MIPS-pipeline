#function main
MAIN:
nop
li $t0, 0x40000000
sw $zero, 8($t0)
li $t3, 28000
li $t2, 0
sw $t3, 0($t0)
sw $t2, 4($t0)
li $t3, 3
sw $t3, 8($t0)					#启动定时器

li $t1, 0x40000014
lw $k1, 0($t1)					#起始时刻

li $s0, 0								#$s0为buffer
li $s1, 127								#$s1为N	  int N = buffer[0]
move $a0, $s0								#第一个形参为buffer
li $a1, 0								#left为1
move $a2, $s1								#right为N
jal QUICKSORT
nop
j END
#endfunction main

#function Quicksort
QUICKSORT:
addi $sp, $sp, -28
sw $s5, 24($sp)
sw $s4, 20($sp)
sw $s3, 16($sp)
sw $s2, 12($sp)
sw $s1, 8($sp)
sw $s0, 4($sp)
sw $ra, 0($sp)

move $s0, $a0								#$s0为arr
move $s1, $a1								#$s1为i
move $s2, $a2								#$s2为j
move $s4, $a1								#$s4为left
move $s5, $a2								#$s5为right
sll $t0, $s4, 2								#left -> 4*left
add $t0, $t0, $s0							#&arr[left]
lw $s3, 0($t0)								#$s3为key
WHILE1:
sll $t0, $s2, 2
add $t0, $t0, $s0							#&arr[j]
lw $t0, 0($t0)
nop								#arr[j]
sge $t0, $t0, $s3							#arr[j] >= key
slt $t1, $s1, $s2							#i < j
and $t0, $t0, $t1
nop							#arr[j] >= key && i < j
beq $t0, $zero, ENDWHILE2
WHILE2:
addi $s2, $s2, -1							#j--
sll $t0, $s2, 2
add $t0, $t0, $s0							#&arr[j]
lw $t0, 0($t0)
nop								#arr[j]
sge $t0, $t0, $s3							#arr[j] >= key
slt $t1, $s1, $s2							#i < j
and $t0, $t0, $t1
nop							#arr[j] >= key && i < j
bne $t0, $zero, WHILE2
ENDWHILE2:
sll $t0, $s1, 2
add $t0, $t0, $s0							#&arr[i]
lw $t0, 0($t0)
nop								#arr[i]
sle $t0, $t0, $s3							#arr[i] <= key
slt $t1, $s1, $s2							#i < j
and $t0, $t0, $t1
nop							#arr[j] > key && i < j
beq $t0, $zero, ENDWHILE3
WHILE3:
addi $s1, $s1, 1							#i++
sll $t0, $s1, 2
add $t0, $t0, $s0							#&arr[i]
lw $t0, 0($t0)
nop								#arr[i]
sle $t0, $t0, $s3							#arr[i] <= key
slt $t1, $s1, $s2							#i < j
and $t0, $t0, $t1
nop							#arr[j] > key && i < j
bne $t0, $zero, WHILE3
ENDWHILE3:
slt $t0, $s1, $s2
nop
bne $t0, $zero, ENDIF1
IF1:
j ENDWHILE1
nop
ENDIF1:
sll $a0, $s1, 2
sll $a1, $s2, 2
add $a0, $s0, $a0							#&arr[i]
add $a1, $s0, $a1							#&arr[j]
jal SWAP
nop									#交换arr[i]和arr[j]
j WHILE1
nop
ENDWHILE1:
sll $t0, $s4, 2
add $t0, $s0, $t0							#&arr[left]
sll $t1, $s1, 2
add $t1, $s0, $t1							#&arr[i]
lw $t1, 0($t1)
nop								#arr[i]
sw $t1, 0($t0)								#arr[left] = arr[i]
sll $t0, $s1, 2
add $t0, $s0, $t0							#&arr[i]
sw $s3, 0($t0)								#arr[i] = key

addi $t0, $s1, -1							#i-1
slt $t0, $s4, $t0
nop							#left < i-1
beq $t0, $zero, ENDIF2
IF2:
move $a0, $s0								#arr
move $a1, $s4								#left
addi $a2, $s1, -1							#i-1
jal QUICKSORT
nop
ENDIF2:

addi $t0, $s1, 1							#i + 1
slt $t0, $t0, $s5
nop							#i+1 < right
beq $t0, $zero, ENDIF3
IF3:
move $a0, $s0
addi $a1, $s1, 1
move $a2, $s5
jal QUICKSORT
nop
ENDIF3:
add $v0, $zero, $zero
lw $s5, 24($sp)
lw $s4, 20($sp)
lw $s3, 16($sp)
lw $s2, 12($sp)
lw $s1, 8($sp)
lw $s0, 4($sp)
lw $ra, 0($sp)
addi $sp, $sp, 28
nop
jr $ra
nop
#endfunction Quicksort


#function Swap
SWAP:
lw $t0, 0($a0)
lw $t1, 0($a1)
sw $t0, 0($a1)
sw $t1, 0($a0)
jr $ra
nop
#endfunction Swap

#function Irq
Irq:
li $t0, 15
and $k1, $t1, $k1
li $t0, 0
nop
beq $k1, $t0, h0000
li $t0, 1
nop
beq $k1, $t0, h0001
li $t0, 2
nop
beq $k1, $t0, h0010
li $t0, 3
nop
beq $k1, $t0, h0011
li $t0, 4
nop
beq $k1, $t0, h0100
li $t0, 5
nop
beq $k1, $t0, h0101
li $t0, 6
nop
beq $k1, $t0, h0110
li $t0, 7
nop
beq $k1, $t0, h0111
li $t0, 8
nop
beq $k1, $t0, h1000
li $t0, 9
nop
beq $k1, $t0, h1001
li $t0, 10
nop
beq $k1, $t0, h1010
li $t0, 11
nop
beq $k1, $t0, h1011
li $t0, 12
nop
beq $k1, $t0, h1100
li $t0, 13
nop
beq $k1, $t0, h1101
li $t0, 14
nop
beq $k1, $t0, h1110
li $t0, 15
nop
beq $k1, $t0, h1111
h0000:
li $t1, 0x1fc
j STOP_BCD
nop
h0001:
li $t1, 0x160
j STOP_BCD
nop
h0010:
li $t1, 0x1da
j STOP_BCD
nop
h0011:
li $t1, 0x1f2
j STOP_BCD
nop
h0100:
li $t1, 0x166
j STOP_BCD
nop
h0101:
li $t1, 0x1b6
j STOP_BCD
nop
h0110:
li $t1, 0x1be
j STOP_BCD
nop
h0111:
li $t1, 0x1e0
j STOP_BCD
nop
h1000:
li $t1, 0x1fe
j STOP_BCD
nop
h1001:
li $t1, 0x1f6
j STOP_BCD
nop
h1010:
li $t1, 0x1ef
j STOP_BCD
nop
h1011:
li $t1, 0x1ff
j STOP_BCD
nop
h1100:
li $t1, 0x19d
j STOP_BCD
nop
h1101:
li $t1, 0x1fd
j STOP_BCD
nop
h1110:
li $t1, 0x19f
j STOP_BCD
nop
h1111:
li $t1, 0x18f
j STOP_BCD
nop
STOP_BCD:
li $t2, 0x40000010
sw $t1, 0($t2)
jr $k0

#endfunct
END:
li $t0, 0x40000014
lw $t1, 0($t0)
nop
sub $k1, $t1, $k1

j Irq       #0x80000004







