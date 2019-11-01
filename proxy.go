package main

import "C"
import (
	"sync"
	"unsafe"
)

type (
	index    uint8
	store    map[index]interface{}
	callback struct {
		callback interface{}
		arg      unsafe.Pointer
	}
)

var (
	storage = make(store)
	mutex   sync.Mutex
)

//export evenNumberCallbackProxy
func evenNumberCallbackProxy(i C.uint, num int) {
	c := getCallback(index(i))
	c.callback.(func(int))(num)
}

//export userCallbackProxy
func userCallbackProxy(i C.uint) {
	c := getCallback(index(i))
	c.callback.(func(unsafe.Pointer))(c.arg)
}

func registerCallback(c interface{}, arg unsafe.Pointer) C.uint {
	mutex.Lock()
	i := index(len(storage))
	storage[i] = &callback{
		callback: c,
		arg:      arg,
	}
	mutex.Unlock()

	return C.uint(i)
}

func getCallback(i index) *callback {
	mutex.Lock()
	defer mutex.Unlock()
	return storage[i].(*callback)
}

func unregisterCallback(i C.uint) {
	mutex.Lock()
	delete(storage, index(i))
	mutex.Unlock()
}
