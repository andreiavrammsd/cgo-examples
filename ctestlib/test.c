#include "test.h"

int sum(int a, int b) {
	return a + b;
}

const char* get_string() {
	return "string sent from C";
}

void print_string(char* a) {
	printf("string sent from Go: %s\n", a);
}

void print_buffer(unsigned char *buf, size_t size) {
	for (uint i = 0; i < size; i++) {
		printf("%X", buf[i]);
	}
	printf("\n");
}

int point_diff(point p) {
	return p.x - p.y;
}

void pass_void_pointer(void *ptr) {
    printf("%d\n", *((int*)ptr));
}

void generate_numbers(uint num, uint callback) {
	void evenNumberCallbackProxy(uint, int);

	for (uint i = 0; i <= num; i++) {
		if (i % 2 == 0) {
			evenNumberCallbackProxy(callback, i);
		}
	}
}

void user_action(uint callback) {
	void userCallbackProxy(uint);

	for (int i = 0; i < 5; i++) {
		userCallbackProxy(callback);
	}
}
