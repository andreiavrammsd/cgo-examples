.PHONY: all c go run env clean

all: c go run

env:
	docker run --rm -ti -v $(shell pwd):/src -w /src golang:1.24.2

c:
	mkdir -p build
	gcc -c -Wall -Werror -fpic -o build/test.o ctestlib/test.c
	gcc -shared -o build/libtest.so build/test.o
	ar rcs build/libtest.a build/test.o

go:
	go build -o build/app *.go

run:
	./build/app

test: c go
	./build/app > build/app.out
	diff build/app.out app.expected_out

clean:
	rm -rf build/