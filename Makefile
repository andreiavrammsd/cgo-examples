.PHONY: all c go run env

TESTLIBPATH="./ctestlib"

all: c go run

env:
	docker build --tag cgo .
	docker run --rm -ti -v $(shell pwd):/src cgo

c:
	gcc -c -Wall -Werror -fpic -o ${TESTLIBPATH}/test.o ${TESTLIBPATH}/test.c
	gcc -shared -o ${TESTLIBPATH}/libtest.so ${TESTLIBPATH}/test.o

go:
	go build -o app *.go

run:
	./app
