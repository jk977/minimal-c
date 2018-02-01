/*
 * Hello world program written without the C standard library.
 */

typedef enum { STDIN, STDOUT, STDERR } FileDescriptor;

int sys_write(FileDescriptor fd, char const* buffer, int size);
void sys_exit(int status);

static int str_length(char const* str) {
    int len = 0;

    while (*str != 0) {
        len++;
        str++;
    }

    return len;
}

int print(char const* buffer) {
    int len = str_length(buffer);
    return sys_write(STDOUT, buffer, len);
}

void _start(void) {
    print("Hello, world!\n");
    print("Goodbye, world!\n");
    sys_exit(0);
}

