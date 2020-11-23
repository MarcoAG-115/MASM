;Marco Gonzalez
;Marco_Gonzalez.asm
;Project 4
;02 November 2020
;Description:
;The program takes two strings (s1 & s2) that represent words. The word in s2 should be the same length of the word in s2. The program checks
;if s2 is an anagram of s1 by populating the counter arrays c1 & c2, which represent s1 & s2 respectively. Each index of c1 & c2 represents
;the unique characters of s1 & s2. The elements in c1 & c2 represent the number of times that a unique character appears in s1 & s2. After
;c1 & c2 are populated, the program compares c1 & c2. If the arrays are identical, then eax is set to 1 (s1 & s2 are found to be anagrams of
;one another). Otherwise, eax is set to zero (s1 & s2 are found to not be anagrams).
;Citations:
;I used Dr. Li's slides and handouts to learn about loops, jumps (e.g. JNZ), and other operators (e.g. MOVZX & CMP) in assembly language.
;I used Dr. Li's Project 4 template file and completed the missing lines.
;I used my Project 3 file as a reference since similar concepts were present in this project.
;I discussed with William Baldwin on how to debug this project.


.386
.model flat,stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

.data
    s1 byte "GARDEN"
    s2 byte "DANGER"
    c1 byte 26 dup(0)                   ;counter for each letter in s1
    c2 byte 26 dup(0)                   ;counter for each letter in s2
.code
    main proc
        mov edx, 0                      ;clears registers for debugging
        mov ebx, 0
        mov ecx, 0
        mov esi, 0
        mov edi, 0

        mov eax, 0                      ;we will assume that we do not have an anagram

        mov ecx, LENGTHOF s1            ;(1) iterate lengthof s1 times

        mov esi, 0                      ;start at the first byte of s1 and s2

        CounterLoop:                    ;this will increment the proper 'elements' of c1 and c2
            movzx edi, s1[esi]          ;move the value from s1 into edi

            sub edi, 65

            inc c1[edi]                 ;(2) increment the counter at the value - 65.
                                        ;subtract 65 because the ASCII value of A is 65, B is 66, C is 67...
                                        ;when you subtract 65 then the sum of all the As will be stored in 'index' 0
                                        ;Bs in 'index' 1, Cs in 'index' 2...

            movzx edi, s2[esi]          ;(3) Do the same procedure for s2

            sub edi, 65

            inc c2[edi]                 ;(4) increment the second counter at the value - 65.

            inc esi                     ;increment esi
            loop CounterLoop            ;after this loop terminates our couter arrays will have the proper values

            mov esi, 0                  ;(5) start checking the counter arrays at 'index' 0

            mov ecx, LENGTHOF c1        ;(6)iterate lengthof c1 times

        VerifyLoop:
            mov bl, c1[esi]             ;(7) move value of c1 into bl

            ;mov dl, c2[esi]            ;uncomment for debugging

            cmp bl, c2[esi]             ;(8) check bl vs the value of c2

            jnz NoAna                   ;(9) if they are not equal then we do not have an anagram.  jump to NoAna

            inc esi                     ;increment esi
            loop VerifyLoop
            mov eax, 1                  ;if the loop terminates and we have not jumped then we know we have an anagram

            ; you can uncomment the following line to print out the result
            ;call WriteInt

        NoAna:
            invoke ExitProcess, 0

    main endp
end main
