#Name: Carlos Esponda cfe160030 08/28/2017
  #CS 3340.502 Instructor: Karen Mazidi
  #Program to add the four last digits of my cellphone number

#data section
	.data
digit1: .word 9 #first digit
digit2: .word 4 #second digit
digit3: .word 7 #third digit
digit4: .word 7 #fourth digit
sum:	.word 0 #sum of the four digits intialized with 0

  #use 2 registers to get two sums and then add those together and put it in one of the registers
  #store the sum into the sum and then exit the program
	.text
	lw  $t1,digit1
  	lw  $t2,digit2
  	lw  $t3,digit3
  	lw  $t4,digit4
  	add $t0,$t1,$t2
  	add $t5,$t3,$t4
  	add $t0,$t0,$t5
  sw  $t0,sum

  	li  $v0,10
 	syscall
