.intel_syntax noprefix

.text
.globl sys_write, sys_exit
.type sys_write, %function
.type sys_exit, %function

sys_write:
    # param 1 (ebp+16): file descriptor to write to
    # param 2 (ebp+12): pointer to null-terminated 8-bit character array
    # param 3 (ebp+8): length of string to print
    push ebp
    mov ebp, esp
    push ebx

    mov edx, [ebp+16]   # string length in edx
    mov ecx, [ebp+12]   # char pointer in ecx
    mov ebx, [ebp+8]    # file descriptor in ebx
    mov eax, 4          # system call value for write
    int 0x80

    pop ebx
    leave
    ret

sys_exit:
    # param 1 (ebp+8): exit status
    push ebp
    mov ebp, esp

    mov ebx, [ebp+8]    # not preserving value due to exiting
    mov eax, 1          # system call value for exit
    int 0x80

    leave
    ret
