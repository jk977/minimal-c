.intel_syntax noprefix

.text
.globl sys_read, sys_write, sys_exit, _start
.type sys_read,     %function
.type sys_write,    %function
.type sys_exit,     %function

sys_read:
    # param 1 (ebp+16): number of bytes to read
    # param 2 (ebp+12): pointer to buffer to read into
    # param 3 (ebp+8):  file descriptor to read from
    push ebp
    mov ebp, esp
    push ebx

    mov edx, [ebp+16]   # byte count in edx
    mov ecx, [ebp+12]   # buffer pointer in ecx
    mov ebx, [ebp+8]    # file descriptor in ebx
    mov eax, 3          # system call value for read
    int 0x80

    pop ebx
    leave
    ret

sys_write:
    # param 1 (ebp+16): length of string to print
    # param 2 (ebp+12): pointer to null-terminated array of 8-bit characters
    # param 3 (ebp+8):  file descriptor to write to
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

_start:
    call main
    push eax
    call sys_exit
    ret
