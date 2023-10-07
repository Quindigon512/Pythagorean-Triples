#######################################################
# Author:    Quinn Trate
# Date:      November 17, 2022
# Course:    CMPSC 312 Computer Architecture
# Language:  MIPS
# Simulator: MARS 4.5
# OS:	     MS Windows 10 Home
# Purpose:   Allows the User to Enter 3 Integers
#            at a Time and Tests Whether or not
#	     They are Pythagorean Triples
#######################################################

		.data
newLine: 	.asciiz "\n"
prompt: 	.asciiz "Please enter 3 positive integers:\n"
true: 		.asciiz "The integers are a Pythagorean Triple!\n"
false: 		.asciiz "The integers are not a Pythagorean Triple.\n"
nextPrompt: 	.asciiz "Do you want to test more integers? (Type 0 to quit, 1 to run again.): "
error:		.asciiz "\nError: Integer is not Positive. Please Enter Postive Integer.\n"
border:		.asciiz "*************************************************************************"
		.text
		.globl main
		
main: 		li $v0, 4					# Load System Call Code to Print a String
		la $a0, prompt					# Load Address of "firstPrompt"
		syscall 					# Print Contents of "firstPrompt"
		jal readInt					# Jump to "readInt"
		
readInt:	li $v0, 5					# Get Integer from Keyboard
		syscall 					# Read the Integer into $v0
		move $s1, $v0 					# Copy Contents of $v0 into $s1
		ble $s1, $zero, exception			# If Integer is <= 0, Jump to "exception"
		li $v0, 5					# Get Integer from Keyboard
		syscall 					# Read the Integer into $v0
		move $s2, $v0 					# Copy Contents of $v0 into $s1
		ble $s2, $zero, exception			# If Integer is <= 0, Jump to "exception"
		li $v0, 5					# Get Integer from Keyboard
		syscall 					# Read the Integer into $v0
		move $s3, $v0 					# Copy Contents of $v0 into $s1
		ble $s3, $zero, exception			# If Integer is <= 0, Jump to "exception"
		li $v0, 4					# Load System Call Code to Print a String
		la $a0, newLine					# Load Address of "newLine"
		syscall 					# Print Contents of "newLine"
		jal calculations				# Jump to "calculation"
		
calculations:	mul $t0, $s1, $s1				# Get Square of "firstInteger" in "firstProd"
		mul $t1, $s2, $s2				# Get Square of "secondInteger" in "secondProd"
		mul $t2, $s3, $s3				# Get Square of "thirdInteger" in "thirdProd"
		jal addInts1And2				# Jump to "addInts1And2"
		
addInts1And2:	add $s4, $t0, $t1				# Get Sum of Square of First and Second Nums
		bne $s4, $t2, addInts1And3			# If Sum of Square of First and Second Nums != Square of Third Num, go to Next Check
		li $v0, 4					# Load System Call Code to Print a String
		la $a0, true					# Load Address of "true"
		syscall 					# Print Contents of "true"
		jal newPrompt					# Jump to New Prompt
		
addInts1And3:	add $s5, $t0, $t2				# Get Sum of Square of First and Third Nums
		bne $s5, $t1, addInts2And3			# If Sum of Square of First and Third Nums = Square of Second Num
		li $v0, 4					# Load System Call Code to Print a String
		la $a0, true					# Load Address of "true"
		syscall 					# Print Contents of "true"
		jal newPrompt					# Jump to New Prompt
		
addInts2And3:   add $s6, $t1, $t2				# Get Sum of "secondProd" and "thirdProd"
		bne $s6, $t0, wrong				# If Sum of Square of Second and Third Nums != Square of First Num, go to the "wrong" Prompt
		li $v0, 4					# Load System Call Code to Print a String
		la $a0, true					# Load Address of "true"
		syscall 					# Print Contents of "true"
		jal newPrompt					# Jump to New Prompt
		
wrong:		li $v0, 4					# Load System Call Code to Print a String
		la $a0, false					# Load Address of "false"
		syscall 					# Print Contents of "false"
		jal newPrompt					# Jump to New Prompt
		
newPrompt:	li $v0, 4					# Load System Call Code to Print a String
		la $a0, border					# Load Address of "border"
		syscall 					# Print Contents of "border"
		li $v0, 4					# Load System Call Code to Print a String
		la $a0, newLine					# Load Address of "newLine"
		syscall 					# Print Contents of "newLine"
		li $v0, 4					# Load System Call Code to Print a String
		la $a0, nextPrompt				# Load Address of "nextPrompt"
		syscall 					# Print Contents of "nextPrompt"
		li $v0, 5					# Get Integer from Keyboard
		syscall 					# Read the Integer into $v0
		move $s7, $v0					# Read the Integer into $s7
		li $v0, 4					# Load System Call Code to Print a String
		la $a0, border					# Load Address of "border"
		syscall 					# Print Contents of "border"
		li $v0, 4					# Load System Call Code to Print a String
		la $a0, newLine					# Load Address of "newLine"
		syscall 					# Print Contents of "newLine"
		bne $s7, $zero, main				# If the Integer is Greater Than Zero, Go Back to "main"
		jal endProgram					# Junp to "endProgram"
		
exception:	li $v0, 4					# Load System Call Code to Print a String
		la $a0, error					# Load Address of "error"
		syscall 					# Print Contents of "error"
		li $v0, 4					# Load System Call Code to Print a String
		la $a0, newLine					# Load Address of "newLine"
		syscall 					# Print Contents of "newLine"
		jal main					# Jump to "main"
		
endProgram: 	li $v0, 10 					# Load System Call to Exit
		syscall 					# Terminate Program
