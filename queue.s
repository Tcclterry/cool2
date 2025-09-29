.data
    _int_tag:       .word   4
    _string_tag:    .word   5
    _bool_tag:      .word   6
    _empty_string:  .asciiz ""
    _nl:            .asciiz "\n"
    _void:          .word   0        
    _const0:        .word   0
    _const1:        .word   1
    _const_true:    .word   1
    _const_false:   .word   0
.text
.globl  main
.globl  _init
.globl  _Main_main
.globl  _Queue_myInitQueue
.globl  _Queue_myIsEmpty
.globl  _Queue_myEnqueue
.globl  _Queue_myDequeue
.globl  _Queue_myFrontData
.globl  _Queue_myPrint
.globl  _Queue_mySize
.globl  _NewNode_myInit
.globl  _NewNode_myGData
.globl  _NewNode_myGNext
.globl  _NewNode_mySetNext
_init:
    jr $ra
_NewNode_myInit:
    # $a0: self   $a1: i   $a2: n
    sw $a1, 12($a0)     
    sw $a2, 16($a0)     
    jr $ra
_NewNode_myGData:
    lw $v0, 12($a0)
    jr $ra
_NewNode_myGNext:
    lw $v0, 16($a0)
    jr $ra
_NewNode_mySetNext:
    sw $a1, 16($a0)
    move $v0, $a0
    jr $ra
_Queue_myInitQueue:
    sw $zero, 12($a0)  
    sw $zero, 16($a0)   
    move $v0, $a0
    jr $ra
_Queue_myIsEmpty:
    lw $t0, 12($a0)     
    beq $t0, $zero, _empty_true
    li $v0, 0
    jr $ra
_empty_true:
    li $v0, 1
    jr $ra
_Queue_myEnqueue:
    addiu $sp, $sp, -24
    sw $ra, 20($sp)
    sw $s0, 16($sp)     
    sw $s1, 12($sp)     
    move  $s0, $a0
    move  $s1, $a1
    jal _Queue_myIsEmpty
    beq $v0, $zero, _enqueue_else
    li $a0, 28          
    li $v0, 9
    syscall
    move $t0, $v0
    sw $s1, 12($t0)    
    sw $zero, 16($t0)    
    sw $t0, 12($s0)      
    sw $t0, 16($s0)      
    j _enqueue_done
_enqueue_else:
    lw $t1, 16($s0)    
    li $a0, 28
    li $v0, 9
    syscall
    move $t0, $v0
    sw $s1, 12($t0)
    sw $zero, 16($t0)
    sw $t0, 16($t1)     
    sw $t0, 16($s0)     
_enqueue_done:
    lw $ra, 20($sp)
    lw $s0, 16($sp)
    lw $s1, 12($sp)
    addiu $sp, $sp, 24
    move $v0, $s0
    jr $ra
_Queue_myDequeue:
    addiu $sp, $sp, -24
    sw $ra, 20($sp)
    sw $s0, 16($sp)
    move $s0, $a0
    jal _Queue_myIsEmpty
    beq $v0, $zero, _dequeue_else
    li $v0, 4
    la $a0, _str_empty
    syscall
    j _dequeue_done
_dequeue_else:
    lw $t0, 12($s0)     
    lw $v0, 12($t0)     
    lw $t1, 16($t0)     
    sw $t1, 12($s0)      
    beq $t1, $zero, _dequeue_now_empty
    j _dequeue_return
_dequeue_now_empty:
    sw $zero, 16($s0)   
_dequeue_return:
    lw $ra, 20($sp)
    lw $s0, 16($sp)
    addiu $sp, $sp, 24
    jr $ra
_Queue_myFrontData:
    jal _Queue_myIsEmpty
    bne $v0, $zero, _front_empty
    lw $t0, 12($a0)
    lw $v0, 12($t0)
    jr $ra
_front_empty:
    li $v0, 0
    jr $ra
_Queue_myPrint:
    addiu $sp, $sp, -32
    sw $ra, 28($sp)
    sw $s0, 24($sp)
    sw $s1, 20($sp)    
    move $s0, $a0
    jal _Queue_myIsEmpty
    beq $v0, $zero, _print_else
    li $v0, 4
    la $a0, _str_empty
    syscall
    j _print_done
_print_else:
    lw $s1, 12($s0)      
_print_loop:
    beq $s1, $zero, _print_done
    lw $t0, 12($s1)      
    lw $t1, 0($t0)      
    li $t2, 5           
    bne $t1, $t2, _print_next
    lw $a0, 8($t0)      
    li $v0, 4
    syscall
_print_next:
    li $a0, 32         
    li $v0, 11
    syscall
    lw $s1, 16($s1)      
    j _print_loop
_print_done:
    li $v0, 4
    la $a0, _nl
    syscall
    lw $ra, 28($sp)
    lw $s0, 24($sp)
    lw $s1, 20($sp)
    addiu $sp, $sp, 32
    jr $ra
_Queue_mySize:
    li $v0, 0
    lw $t0, 12($a0)     
_size_loop:
    beq $t0, $zero, _size_done
    addiu $v0, $v0, 1
    lw $t0, 16($t0)
    j _size_loop
_size_done:
    jr $ra
_Main_main:
    li $a0, 32          
    li $v0, 9
    syscall
    move $s0, $v0
    jal _Queue_myInitQueue
    move $a0, $v0
    jal _Queue_myPrint
    la $a1, _str_first
    move $a0, $s0
    jal _Queue_myEnqueue
    li $a1, 2
    move $a0, $s0
    jal _Queue_myEnqueue
    la $a1, _str_3rd
    move $a0, $s0
    jal _Queue_myEnqueue
    move $a0, $s0
    jal _Queue_myPrint
    move $a0, $s0
    jal _Queue_myFrontData
    move $a0, $v0
    jal _print_obj     
    li $v0, 4
    la $a0, _nl
    syscall
    move $a0, $s0
    jal _Queue_myDequeue
    move $a0, $s0
    jal _Queue_myPrint
    move $a0, $s0
    jal _Queue_myDequeue
    move $a0, $s0
    jal _Queue_myDequeue
    move $a0, $s0
    jal _Queue_myPrint
    jr $ra
_print_obj:
    li $v0, 4
    la $a0, _str_first
    syscall
    jr $ra
.data
_str_empty:  .asciiz "Nothing in Queue\n"
_str_first:  .asciiz "firstone"
_str_3rd:    .asciiz "3rd"
.text
main:
    jal _init
    jal _Main_main
    li $v0, 10         
    syscall
