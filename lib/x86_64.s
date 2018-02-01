.intel_syntax noprefix

.text
.globl sys_read, sys_write, sys_exit, _start
.type sys_read,     %function
.type sys_write,    %function
.type sys_exit,     %function

sys_read:
    # param 1 (rdi): number of bytes to read
    # param 2 (rsi): pointer to buffer to read into
    # param 3 (rdx): file descriptor to read from
    mov rax, 0
    syscall
    ret

sys_write:
    # param 1 (rdi): file descriptor to write to
    # param 2 (rsi): pointer to null-terminated array of 8-bit characters
    # param 3 (rdx): length of string to print
    mov rax, 1
    syscall
    ret

sys_exit:
    # param 1 (rdi): exit status
    mov rax, 60
    syscall
    ret

_start:
    call main
    mov rdi, rax
    call sys_exit
    ret
