format ELF64 executable

macro print item {
	mov rax, 1
	mov rdi, 2
	mov rsi, item
	mov rdx, item#_len
	syscall
}	

printn:	
  mov     r9, -3689348814741910323
  sub     rsp, 40
  mov     BYTE [rsp+31], 10
  lea     rcx, [rsp+30]
.L2:
  mov     rax, rdi
  lea     r8, [rsp+32]
  mul     r9
  mov     rax, rdi
  sub     r8, rcx
  shr     rdx, 3
  lea     rsi, [rdx+rdx*4]
  add     rsi, rsi
  sub     rax, rsi
  add     eax, 48
  mov     BYTE [rcx], al
  mov     rax, rdi
  mov     rdi, rdx
  mov     rdx, rcx
  sub     rcx, 1
  cmp     rax, 9
  ja      .L2
  lea     rax, [rsp+32]
  mov     edi, 1
  sub     rdx, rax
  xor     eax, eax
  lea     rsi, [rsp+32+rdx]
  mov     rdx, r8
  mov     rax, 1
  syscall
  add     rsp, 40
  ret
	
macro for item, lower, upper {
.#item#start:
	mov QWORD [item], lower

.#item#loop_start:
	cmp QWORD [item], upper
	jg .#item#loop_end
}

macro endfor item {
	inc QWORD [item]
	jmp .#item#loop_start
.#item#loop_end:
}

macro exit code {
	mov rax, 60
	mov rdi, code
	syscall
}

i: rq 1
j: rq 1
k: rq 1
	
entry _start
_start:
	lower = 1
	upper = 100
	
	for i, lower, upper
	  print newline
	  mov rdi, qword [i]
	  call printn

	  for j, lower, upper
  		print tab
	    mov rdi, qword [j]
			call printn

	    ;; print i + j 
			print newline
	    repeat 2
	      print tab
	    end repeat
	
			mov rdi, qword[i]
	    add rdi, qword[j]
	    call printn
			print newline
	
  	for k, lower, upper
				repeat 3
					print tab
				end repeat
				mov rdi, qword [k]
	      call printn

		    repeat 4
	        print tab
				end repeat
				;; rdi got cleared by printn, re-store k and then add j + i
				mov rdi, qword [k]
				add rdi, qword [j]
				add rdi, qword [i]
	      call printn
  		endfor k
    endfor j
	endfor i
	
	exit 0

msg:
	file "file.txt", 0

msg_len = $-msg	

tab:
	db 9
tab_len = 1

newline:
	db 10
newline_len = 1
