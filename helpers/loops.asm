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
