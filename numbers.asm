format ELF64 executable

	
include 'helpers/printing.asm'
include 'helpers/loops.asm'
include 'helpers/macros.asm'	

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
