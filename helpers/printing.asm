include 'macros.asm'
	
;;; Print a labeled/constant item
macro print item {
	sys3 1, 2, item, item#_len
}

;;; Print a number in RDI to stdout
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

;; Print string of untdetermined length
;;; to stdout
;;; @params: rdi - the string
puts:
    mov rdx, 0            ; initialize rdx (string length)
.find_null:
    cmp byte [rdi + rdx], 0  ; check for null-terminator
    jz .found_null
    inc rdx
    jmp .find_null
.found_null:
    mov rax, 0x1          ; syscall number for sys_write
    mov rdi, 1            ; file descriptor (stdout)
  	syscall

	  print newline
    ret
	
tab:
	db 9
tab_len = 1

newline:
	db 10
newline_len = 1
	
