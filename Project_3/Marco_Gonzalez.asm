;Marco Gonzalez
;Marco_Gonzalez.asm
;Project 3
;04 October 2020
;Description:
;The program takes an populated array of 2 - 100 (input) and a shift value less than the array length (shift).
;This program uses input to create a shifted array (output) which has the same elements from input but they are
;all shifted to the right by the amount in the shift variable. If an element is shifted out outside the bounds
;of output, then the element should wrap around to the front of output. The first loop shifts all the elements
;that wrap around to the front of output. The second loop shifts the remaining unshifted elements. The third 
;loop in the debugging section is used to see if the elements in output were placed correctly by the program.
;Citations:
;I used Dr. Li's slides and handouts to learn about loops, jumps, and other operators in assembly language.
;I used Stackoverflow.com to learn how to debug in VS, how to check the elements in an array, & how to use jc.
;I discussed with William Baldwin to get a better understanding of how loops and jumps work.

.386
	.model flat,stdcall
	.stack 4096
	ExitProcess proto,dwExitCode:dword
.data
	input BYTE 1,2,3,4,5,6,7,8
	output BYTE LENGTHOF input DUP(?)
	shift DWORD 3
.code
	main proc
		;clear registers eax, ebx, ecx
		xor eax, eax
		xor ebx, ebx
		xor ecx, ecx

		;eax is set to the number of elements between the element at the value of shift and the element at the end of input
		mov eax, LENGTHOF input
		sub eax, shift

		;ebx is set to the eax value to be an index for the input array
		;the input index will start at the same value as LENGTHOF input - shift
		mov ebx, eax
		
		;ecx is set to zero to be an index for output array
		;output is filled from left to right
		mov ecx, 0

		;loop 1 shifts the elements in the positions input[LENGTHOF input - shift] to the end of input
		;loop 1 iterates the same number of times as shift
		l1:
				
				;an input element from LENGTHOF input - shift to end of input are stored in al every iteration
				mov al, input[ebx]

				;the input element stored in al is stored in output from left to right starting at output[0]
				mov output[ecx], al

				;ecx and ebx increment by one every iteration
				inc ecx
				inc ebx

				;eax is set to the current value of the index for output to serve as the counter for the loop
				mov eax, ecx

				;if the difference between the value in eax and shift is zero, then the loop stops iterating
				;if the difference between the value in eax and shift is not zero, then the loop continues iterating
				cmp eax, shift

				;jumps on carry
				jc l1
		
		;eax and ebx registers are cleared
		;ebx will now start from the first element of input
		;ecx continues from where it left off in loop 1
		xor eax, eax
		xor ebx, ebx

		;loop 2 shifts the elements in the positions input[0] to input[shift]
		;loop 2 iterates the same number of times as LENGTHOF input - shift
		l2:
				
				;an input element from 0 to LENGTHOF input - shift are stored in al every iteration
				mov al, input[ebx]

				;the input element stored in al is stored in output from left to right starting at output[shift]
				mov output[ecx], al

				;ecx and ebx increment by one every iteration
				inc ecx
				inc ebx

				;eax is set to the current value of the index for output to serve as the counter for the loop
				mov eax, ecx

				;if the difference between the value in eax and LENGTHOF input is zero, then the loop stops iterating
				;if the difference between the value in eax and LENGTHOF input is not zero, then the loop continues iterating
				cmp eax, LENGTHOF input
				jc l2

		;------------------------------------------------FOR DEBUGGING----------------------------------------------------------
		;to check elements in output uncomment lines with ;; and run debug mode and observe register values

		;eax and ebx registers are cleared.
		;;xor eax, eax
		;;xor ebx, ebx

		;eax is set to zero so that it can increment by one every loop 3 iteration until it is equal to LENGTHOF input
		;;mov eax, 0

		;Loop 3 iterates through output and places output elements in eax
		;eax shows the shifted array's elements from left to right.
		;;l3:
			
			;an element from output is copied into bl every iteration (the order of is from left to right)
			;;mov bl, output[eax]

			;eax is incremented by one
			;;inc eax

			;if the difference between the value in eax and LENGTHOF input is zero, then the loop stops iterating
			;if the difference between the value in eax and LENGTHOF input is not zero, then the loop continues iterating
			;;cmp eax, LENGTHOF input
			;;jc l3
		;------------------------------------------------------------------------------------------------------------------------
		

		invoke ExitProcess, 0
	main endp
end main