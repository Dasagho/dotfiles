#include <>
int main(int argc, char *argv[]) {
	int val1, val2, i;
	val1 = fork();
	if (val1 == 0) {
		for (i = 0; i < 2, i++) {
			val2 = fork();
			if(val2 == 0) {
				if(i % 2== 0) {
					sleep(30);
					exit(0);
				} else {
					sleep(10);
					exit(0);
				}
			} else {
				sleep(20);
				exit(4);
			}
		}
	}
}
