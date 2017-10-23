#Name: Carlos Esponda 
#Program Description: This is a way to calculate the bmi of a person 

	.data
name: .space 32
height: .double 0
weight: .double 0
bmiConstant: .double 703
Calculation: .double 0
UnderLimit: .double 18.5	
NormalLimit: .double 25	
OverLimit:  .double 30	
prompt: .asciiz "What is your name? \n"
HeightPrompt: .asciiz "Please enter your height in inches \n"
WeightPrompt: .asciiz "Please enter your weight in pounds (round to a whole number): \n"
result: .asciiz ",your bmi is: "
UnderweightPrompt: .asciiz "\n This is considered underweight. \,n"
NormalPrompt: .asciiz "\nThis is a normal weight. \n"
OverweightPrompt: .asciiz "\nThis is considered overweight. \n"
ObesePrompt: .asciiz "\nThis is considered Obese.\n"

	.text
	# Asks for name
	li $v0, 4 #syscall for print
	la $a0, prompt
	syscall
	
	# Saves name
	li $v0, 8 # syscall to save name
	la $a0, name
	la $a1, name
	syscall
	
	# Strips the new line off
	la $a0, name #stores name in address
	jal StripNewline
	
	# Asks for Height
	li $v0, 4 #syscall for print
	la $a0, HeightPrompt
	syscall
	
	# Syscall to read a double 
	li $v0, 7 
	syscall
	#Stores a double
	sdc1 $f0, height
	
	#Prints the string to ask for weight
	li $v0, 4#syscall for print
	la $a0, WeightPrompt
	syscall
	
	# Reads double
	li $v0, 7
	syscall
	sdc1 $f0, weight
	
	
	# Finds the bmi
	l.d $f2, height	
	mul.d $f2, $f2, $f2
	
	l.d $f4, weight	
	l.d $f6, bmiConstant	
	mul.d $f4, $f4, $f6	
	
	div.d $f0, $f4, $f2	
	sdc1 $f0, Calculation		
	
	# print name
	li $v0, 4
	la $a0, name
	syscall
	
	# print ", your bmi is: "
	li $v0, 4
	la $a0, result
	syscall
	
	# print BMI
	li $v0, 3
	l.d $f12, Calculation
	syscall
	
	# load the bmi and the bmi-level specifiers
	l.d $f0, Calculation
	l.d $f2, UnderLimit
	l.d $f4, NormalLimit
	l.d $f6, OverLimit
	
	# find bmi level and branch to appropriate response
	c.lt.d $f0, $f2	# if bmi < 18.5, underweight
	bc1t IsUnder
	c.lt.d $f0, $f4	# else if bmi < 25, normal
	bc1t IsNormal
	c.lt.d $f0, $f6	# else if bmi < 30, overweight
	bc1t IsOver
	j IsObese
		
IsUnder:
	li $v0, 4
	la $a0, UnderweightPrompt
	syscall
	j exit			
IsNormal:

	li $v0, 4
	la $a0, NormalPrompt
	syscall
	j exit
IsObese:
	li $v0, 4
	la $a0, ObesePrompt
	syscall
	j exit
	
IsOver:
	li $v0, 4
	la $a0, OverweightPrompt
	syscall
	j exit
	
	
exit:
	# exit program
	li $v0, 10
	syscall
	
# take off the ending newline in an input string
StripNewline:
	loop:	# loop through argument (string) until newline is found
		lb $t0, 0($a0)	
		addi $a0, $a0, 1	
		bne $t0, 10, loop	
		sb $zero, -1($a0)	
		jr $ra