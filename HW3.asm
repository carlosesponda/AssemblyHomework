  #Name: Carlos Esponda
  .data
  #variables for prompt
prompt: .asciiz "Enter Some Text"
c:	.asciiz "Characters: "
w:	.asciiz " Words: "
  #variable to hold user's input
input:   .word 64

  .text
 #beginning of program 
main:
  li $v0, 54 #takes out the dialog box
  la $a0, prompt
  la $a1,input
  li $a2,64
  syscall 

  #puts the values into the argument of the function and allows the user to exit out
  la $a3,input
  beq  $a1,-2,exit
  beq  $a1,-3,exit 
  #beginning of loop	
  jal count
  
  add $t0,$v0,$zero
  #prints the amount of characters and words along with string
  li $v0,4
  la $a0,input
  syscall
  li $v0,4
  la $a0,c
  syscall
  li  $v0,1
  addi $a0,$t0,0
  syscall
  li $v0,4
  la $a0,w
  syscall
  li $v0,1
  add $a0,$v1,$zero
  syscall
  #prints a new line
  li $v0,11
  li $a0, 10
  syscall
  j main  
  
  #uses the stack point
count:
    addi $sp,$sp, -4
    sw $s1,0($sp)
    li $v0,-1
    li $v1,1
    #beginnging of loop
loop: lb   $s1,0($a3)
    beqz $s1,done
    addi $a3,$a3,1
    bne  $s1,32,increment
    addi $v1,$v1,1
increment:
    addi $v0,$v0,1
    j     loop

done: 
lw, $s1, 0($sp)
addi $sp, $sp, 4
jr $ra


exit: li $v0,10
      syscall
