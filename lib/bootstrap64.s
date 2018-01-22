.intel_syntax noprefix

.text
.globl sys_write, sys_exit
.type sys_write, %function
.type sys_exit, %function

sys_write:
    # param 1 (rdi): file descriptor to write to
    # param 2 (rsi): pointer to null-terminated 8-bit character array
    # param 3 (rdx): length of string to print
    mov rax, 1
    syscall
    ret

sys_exit:
    # param 1 (rdi): exit status
    mov rax, 60
    syscall
    ret
