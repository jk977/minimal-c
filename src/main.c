/*
 * Hello world program written without the C standard library.
 */

#include "bootstrap.h"

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

int main(void) {
    print("Hello, world!\n");
    print("Goodbye, world!\n");
    return 0;
}

