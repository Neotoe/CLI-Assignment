#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    int i;
    pid_t pid;

    // Create multiple child processes
    for(i = 0; i < 3; i++) {
        pid = fork();

        if(pid < 0) {
            printf("Fork failed\n");
            exit(1);
        }

        if(pid == 0) {
            // Child process
            printf("Child process created with PID: %d\n", getpid());
            sleep(2);
            exit(0);
        }
    }

    // Parent process cleans up children
    pid_t child_pid;
    while((child_pid = wait(NULL)) > 0) {
        printf("Parent cleaned up child with PID: %d\n", child_pid);
    }

    return 0;
}
