#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>

// Signal handler
void handle_sigterm(int sig) {
    printf("\nParent received SIGTERM. Cleaning resources...\n");
}

void handle_sigint(int sig) {
    printf("\nParent received SIGINT. Exiting gracefully...\n");
    exit(0);
}

int main() {

    signal(SIGTERM, handle_sigterm);
    signal(SIGINT, handle_sigint);

    pid_t child1 = fork();

    if(child1 == 0) {
        sleep(5);
        printf("Child 1 sending SIGTERM to parent\n");
        kill(getppid(), SIGTERM);
        exit(0);
    }

    pid_t child2 = fork();

    if(child2 == 0) {
        sleep(10);
        printf("Child 2 sending SIGINT to parent\n");
        kill(getppid(), SIGINT);
        exit(0);
    }

    // Parent runs indefinitely
    while(1) {
        printf("Parent running... PID: %d\n", getpid());
        sleep(2);
    }

    return 0;
}
