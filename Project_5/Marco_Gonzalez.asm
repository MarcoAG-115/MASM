;----------------- Solution to Project 5 --------------------
; Author: Marco Gonzalez
; Last Modified Date: 11/20/2020
; Summary: This program decrypt and encrypt a message (input) with a key using Vigenere Cipher, the results will be stored in output.
; Description:
; The program accepts a string of letters that will be encrypted and a string of letters that serves as the encryption key.
; The program performs the encryption by using the Vignere cipher. This program also has the ability to decrypt an encrypted
; string of letters by using the given encryption key and the Vignere cipher.
; References:
; I used Dr. Li's slides and handouts to better understand jumps and their conditions. Also, I used the slides to learn about
; instructions like "lea" and "ret".
; I used the provided Project 5 template and completed the missing lines (1-8) of code to finish the project.
; I discussed with William Baldwin to better understand the Vignere cipher in order to code it.
; I also asked William Baldwin to run my program, to check my output, on his computer since I was unable to run my program through
; the Auburn portal.
; I used the following website to see what the correct output should be (https://www.boxentriq.com/code-breaking/vigenere-cipher).

; Uncoment next line and lines 38,39 to use the library)
 includelib C:\Irvine\Kernel32.Lib
 includelib C:\Irvine\User32.Lib
 includelib C:\Irvine\Irvine32.lib
 include C:\Irvine\Irvine32.inc

.386
.model flat, stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

.data
    input byte "JPUESZSBAPANNHTXRTLBVLL"
    key byte "ABCXYZ"
    options BYTE 0                          ; Variable to determine what procedure to execute. 1 for Encryption, otherwise for Decryption
    d byte 26                               ; variable to hold the devisor that will be used for division ( mod )
    output byte lengthof input dup(0)

.code
    main proc
        cmp options, 1                      ; compare value of options to 1
        je En                               ; if value equal to 1 go to encryption rotten
        jne De                              ; if not go to Decryption
        De:
            call Decrypt
            jmp MOVEON                      ; after returning from Decrypt procedure jump to "moveon" so we don't call Decrypt accidentally
        En:
            call Encrypt
            jmp MOVEON                      ; There is no need use jump but just in case is.

        MOVEON:
            mov eax, 0
            ; Print Output to console: uncomment the next 2 lines to activate (Require irvine32.inc)
             lea EDX, output
             CALL writestring
            invoke ExitProcess, 0
    main endp

    Decrypt proc
        mov esi, 0                          ; index of both input and output
        mov edi, 0                          ; index of the key
        mov ecx, LENGTHOF input             ; (1) loop L (LENGTHOF input) times - ecx determines the number of loops performed by Loop L which is the same as the length of input.

        L:
            mov eax, 0                      ; clear EAX
            mov al, input[esi]              ; move cypher character ASCII value into al
            sub al, 65                      ; get the "order" of the character ( A=0, B=1, C=2, ... , Z=25)
            mov bl, key[edi]                ; (2) move the key ASCII character into bl - as the loop iterates, each element in key is moved into bl / edi represents the current element of key
            sub bl, 65                      ; (3) get the "order" of the character ( A=0, B=1, C=2, ... , Z=25) - the "order" of the character is acquired again by subtracting 65 from al
            sub al, bl                      ; (4) subtract the indices to "decrypt" the character - bl is substracted from al to find the ascii value of letter when decrypted
            add al, 26                      ; add 26 in case subtraction result is a negative value
            div d                           ; (5) use divide to get "mod 26". AX will be divided, quotient in AL and reminder in AH. - division is performed to reach a proper ascii value
            add ah, 65                      ; (6) add 65 to convert reminder back from order to the proper ASCII value - this addition insures that the correct ascii values are being assigned
            mov output[esi], ah             ; write ASCII value to output
            inc esi
            inc edi
            cmp edi, lengthof key
            jne Next
            mov edi, 0                      ; (7)if key index reached the end, reset the key index - the key needs to start from its first element when encrypting
        Next:
            loop L
            ret
    Decrypt endp

    Encrypt proc
        mov esi, 0
        mov edi, 0
        mov ecx, lengthof input             ; loop L (LENGTHOF input) times

        L:
            mov eax, 0
            mov al, input[esi]              ; move the input character into al
            sub al, 65                      ; get the order of the character ( A=0, B=1, C=2, ... , Z=25)
            mov bl, key[edi]                ; move the key character into bl
            sub bl, 65                      ; get the "index" of the character ( A=0, B=1, C=2, ... , Z=25)
            add al, bl                      ; (8) add the indices to "encrypt" the character - to encrypt, bl needs to be added to al this time in order receive an ascii value for the encrypted letter
            div d                           ; divide so we can "mod 26"
            add ah, 65                      ; add 65 to convert from order back to the proper ASCII value
            mov output[esi], ah             ; write reminder into the output
            inc esi
            inc edi
            cmp edi, lengthof key           ; if we have reached the end of the key ...
            jne Next
            mov edi, 0                      ; ...reset the key index
        Next:
            loop L
            ret
    Encrypt endp
end main
