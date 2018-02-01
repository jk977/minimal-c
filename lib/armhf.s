.text
.globl sys_read, sys_write, sys_exit
.type sys_read,     %function
.type sys_write,    %function
.type sys_exit,     %function

sys_read:
    @param 1 (r0): number of bytes to read
    @param 2 (r1): pointer to buffer to read into
    @param 3 (r2): file descriptor to read from
    mov r7, #3 @system call value for read
    swi 0x0

sys_write:
    @param 1 (r0): file descriptor to write to
    @param 2 (r1): pointer to null-terminated 8-bit character array
    @param 3 (r2): length of string to print
    mov r7, #4 @system call value for write
    swi 0x0

sys_exit:
    @param 1 (r0): exit status
    mov r7, #1
    swi 0x0
    
