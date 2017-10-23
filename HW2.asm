#Name: Carlos Esponda
	.data
#variables to hold input values
a:  .word	0
b: .word 	0
c: .word 	0
#variable to hold output values
ans1: .word 	0
ans2: .word	0
ans3: .word 	0
#variable to hold the user's name
name: .word 	4
#variable for messages
nprompt: .asciiz 	"What is your name?"
iprompt: .asciiz	"Please enter an integer between 1-100 "
results: .asciiz  "Your answer are: "
#variable for space between numbers
space:   .asciiz " "

	.text
  li $v0,4 #prints the string
  la $a0, nprompt #sets the address
  syscall #calls the system
  li $v0,8 #puts the system call value to v0
  la $a0,name #argument passes the system into name
  la $a1,name
  syscall

  li $v0,4 #prints the string
  la $a0,iprompt#prompts for the integer
  syscall
  
  li $v0,5
  syscall
  sw $v0,a

	li $v0,4 #prints the string
	la $a0,iprompt
	syscall
	
	li $v0,5
	syscall
	sw $v0,b


	li $v0,4 #prints the string
	la $a0,iprompt
	syscall
	
	li $v0,5
	syscall
	sw $v0,c

  #Loads every integer
  lw $t1,a
  lw $t2,b
  lw $t3,c
  #ans1 mathematics
  addi $t0,$t1,2
  subi $t5,$t2,5
  add $t0,$t0,$t5
  sw $t0, ans1
  #ans2 maathematics
  mul $t0,$t1,5
  sub $t0,$t0,$t2
  addi $t0,$t0,10
  sw $t0,ans2
  #ans3 mathematics
  div $t0,$t2,2
  add $t0,$t1,$t0
  sw $t0,ans3
  #prints name
  li $v0,4
  la $a0,name
  syscall
  #prints results
  li $v0,4
  la $a0,results
  syscall

  li $v0,1
  lw $a0,ans1
  syscall

	li $v0,4 #prints the string
	la $a0,space
	syscall

  li $v0,1
  lw $a0,ans2
  syscall

	li $v0,4 #prints the string
	la $a0,space
	syscall


  li $v0,1
  lw $a0,ans3
  syscall
  #terminates the program
  li $v0,10
  syscall
