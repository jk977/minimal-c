#define SYSCALL_WRITE 1
#define SYSCALL_EXIT 60

typedef enum { STDIN, STDOUT, STDERR } FileDescriptor;

static int strlen(char const* str) {
    int length = 0;

    while (*(str++)) { /* check if char is null and increment position */
        length++;
    }

    return length;
}

int write(char const* buffer, FileDescriptor fd) {
    int length = strlen(buffer);
    int status;

    __asm__(
        "syscall"
        : "=a"(status)          /* status = rax */
        : "a"(SYSCALL_WRITE),   /* rax */
          "d"(length),          /* rdx */
          "S"(buffer),          /* rsi */
          "D"(fd)               /* rdi */
    );

    return status;
}

static void exit(int status) {
    __asm__(
        "syscall"
        : /* no output */
        : "a"(SYSCALL_EXIT),
          "D"(status)
    );
}

void _start(void) {
    write("Hello, world!\n", STDOUT);
    exit(0);
}

