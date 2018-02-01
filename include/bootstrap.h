#ifndef BOOTSTRAP_H_
#define BOOTSTRAP_H_

typedef enum { STDIN, STDOUT, STDERR } FileDescriptor;

int sys_write(FileDescriptor fd, char const* buffer, int size);
void sys_exit(int status);

#endif
