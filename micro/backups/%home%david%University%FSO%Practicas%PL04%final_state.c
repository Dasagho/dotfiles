#include <stdio.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
#include <stdlib.h>

#define NPROCESOS 4

int main(void) {

	pid_t pid[NPROCESOS];
	int i, status;

	for (i = 0; i < NPROCESOS; i++) {
		if (pid[i] == 0) {
			pid[i] = fork();
			printf("Hijo creado en iteracion %d\n", i);
			sleep(10);
			exit(i);
		}
	}
	
	if(wait(&status) != 1) {
		printf("Mi hijo ha acadado\n");
	}
	exit(0);

	
	return 0;
}
