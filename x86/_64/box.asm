; Copyright 2016 Patrick Pedersen <ctx.xda@gmail.com>

; Licensed under the Apache License, Version 2.0 (the "License");
; you may not use this file except in compliance with the License.
; You may obtain a copy of the License at

;     http://www.apache.org/licenses/LICENSE-2.0

; Unless required by applicable law or agreed to in writing, software
; distributed under the License is distributed on an "AS IS" BASIS,
; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
; See the License for the specific language governing permissions and
; limitations under the License.

;	## x86_64 Assembly code practice ##

;	DESCRIPTION : Simple ASCII Box generator
;	AUTHOR		: Patrick Pedersen <ctx.xda@gmail.com>
;	LICENSE		: Apache V2 http://www.apache.org/licenses/LICENSE-2.0

; Small Refrence

	; SYS_WRITE
	; 0x4
	;
	; Reserved registers for args :
	;	EAX - syscall
	;	EBX - File Descriptor
	;	ECX - Start address of string
	;	EDX - Length of String

	; SYS_EXIT
	; 0x1
	;
	; Reserved registers for args
	;	EAX - syscall
	;	EBX	- Return

section .data
	
	; Adjustable
	texture:	db '#'			; Box texture
	size: 		equ 0x2 		; Box Size

	endl:		db  0xA 		; Newline

section .bss
; void

section .text

	global _start

_start:

	nop

	; Draw Box

	mov esi, size				; Set Horizontal Size Iterator

	newline:

		mov edi, size			; (Re-)Set Vertical Size Iterator

		column:
			
			; Draw Column
			; SYS_WRITE
			mov eax, 0x4		; Indicate sys_write call
			mov ebx, 0x1		; Open stdout file descriptor
			mov ecx, texture	; Pass first address of texture string
			mov edx, 0x1 		; Indicate size of texture

			int 0x80			; Call Kernel interrupt

			dec edi				; Move to next column

			jnz column 			; Draw next column


		; Draw newline
		; SYS_WRITE
		mov eax, 0x4			; Indicate sys_write call
		mov ecx, endl 			; Pass first address of endl string
		mov edx, 0x1 			; Indicate size of endl

		int 0x80

		dec esi 				; Move to next line

		jnz newline 			; Draw Next line

	mov eax, 0x1				; Call sys_exit
	mov ebx, 0x0				; Return 0 (Success)

	int 0x80					; Call Kernel interrupt

nop