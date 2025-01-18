format ELF64 executable  ; Linux executable format

include 'helpers/printing.asm'
include 'helpers/loops.asm'
include 'helpers/macros.asm'	

i: rq 1
msg:
	db "Program name:", 10
msg_len = $-msg

args_text:	db "Program arguments:", 10
args_text_len = $-args_text
	
entry _start
_start:
	mov r15, [rsp] 					; rsp = ARGC
	sub r15, 2

	print msg											
	mov rsi, [rsp + 8]			; *(rsp + 8) => argv[0] (program name) 
	mov rdi, rsi
	call puts

	print args_text
	
	for i, 1, r15									; skip program name and go from 1..ARGC-2 (skipping 0 and program name)
    mov r14, qword [i]		 			; load the index of current item from ARGC (idx = i)
		imul r14, 8 								; signed multiplication * 4 (idx *= 4)
	  add r14, 16									; + 16 should eq each index of item (idx += 16)
	
	  ;; now r14 has the index w/ offset +16 (e.g. 16, 24, 32, 40, .....)
	  mov rsi, [rsp + r14] 				; idk why but doing evil rsp+r14 maths feels extremely wrong
	  mov rdi, rsi								; load string value to print
	  call puts
	endfor i
	
	exit 0
