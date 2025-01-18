macro sys1 code, arg {
	mov rax, code
	mov rdi, arg
	syscall
}

macro sys2 code, arg1, arg2 {
	mov rax, code
	mov rdi, arg1
	mov rsi, arg2
	syscall
}

macro sys3 code, arg1, arg2, arg3 {
	mov rax, code
	mov rdi, arg1
	mov rsi, arg2
	mov rdx, arg3
	syscall
}

macro exit code {
	sys1 60, code
}
