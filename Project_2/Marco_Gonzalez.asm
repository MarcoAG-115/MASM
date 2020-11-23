;Marco Gonzalez
;Marco_Gonzalez.asm
;Project 2
;18 September 2020
;I used Dr. Li's slides and handouts to start learning
;about assembly language.
;I refrenced the University of Virginia's x86 Assembly
;Guide in order to understand registers more.
;I discussed with William Baldwin to get a better
;understanding of what the code was doing.

.386
.model flat, stdcall
.stack 4096
ExitProcess proto, dwExitCode: dword

.data
	;Sets up the array "input" and the variable "shift"
	input byte 1,2,3,4,5,6,7,8
	shift byte 2
.code
	main proc
		;Clears the registers
		xor eax, eax
		xor ebx, ebx
		xor ecx, ecx
		xor edx, edx

		;Moves through the input array and adds shift to
		;each high and low position of the AX, BX, CX, &
		;DX registers
		mov ah, [input+1]
		add ah, shift
		mov al, [input+2]
		add al, shift

		mov bh, [input+3]
		add bh, shift
		mov bl, [input+4]
		add bl, shift

		mov ch, [input+5]
		add ch, shift
		mov cl, [input+6]
		add cl, shift

		mov dh, [input+7]
		add dh, shift
		mov dl, [input+8]
		add dl, shift

		invoke ExitProcess, 0
	main endp
end main