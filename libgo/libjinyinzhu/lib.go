package main

/*
#ifdef __cplusplus
extern "C" {
#endif

#include <stdlib.h>
typedef struct {
	char* JinZhu;
	char* YinZhu;
	int AddNum;
} AncientJinYinZhu ;

#ifdef __cplusplus
}
#endif
*/
import "C"
import (
	"unsafe"
	"os"
	"strconv"
	_"fmt"
)

//export AncientJinYinZhu_Create
func AncientJinYinZhu_Create(JinZhu *C.char, YinZhu *C.char, AddNum C.int) *C.AncientJinYinZhu {
	tmp := (*C.AncientJinYinZhu)(C.malloc(C.sizeof_AncientJinYinZhu))
	tmp.JinZhu = JinZhu
	tmp.YinZhu = YinZhu
	tmp.AddNum = AddNum
	return tmp
}
//export AncientJinYinZhu_Free
func AncientJinYinZhu_Free(jinyinzhu *C.AncientJinYinZhu) {
	C.free(unsafe.Pointer(jinyinzhu))
}
//export AncientJinYinZhu_Read
func AncientJinYinZhu_Read(jinyinzhu *C.AncientJinYinZhu) (C.int, C.int) {
	JinZhu := C.GoString(jinyinzhu.JinZhu)
	var JinZhuRes C.int = 0
	data1, err := os.ReadFile(JinZhu)
	if err != nil {
		JinZhuRes = 0
	} else {
		res := string(data1)
		num, err2 := strconv.Atoi(res)
		if err2 != nil {
			JinZhuRes = 0
		} else {
			JinZhuRes = C.int(num) - jinyinzhu.AddNum
		}
	}

	YinZhu := C.GoString(jinyinzhu.YinZhu)
	var YinZhuRes C.int = 0
	data2, err := os.ReadFile(YinZhu)
	if err != nil {
		YinZhuRes = 0
	} else {
		res := string(data2)
		num, err2 := strconv.Atoi(res)
		if err2 != nil {
			YinZhuRes = 0
		} else {
			YinZhuRes = C.int(num) - jinyinzhu.AddNum
		}
	}

	return JinZhuRes, YinZhuRes
}
//export AncientJinYinZhu_Write
func AncientJinYinZhu_Write(jinyinzhu *C.AncientJinYinZhu, which C.int, howmany C.int) {
	var Path string
	if which == 0 {
		Path = C.GoString(jinyinzhu.JinZhu)
	} else {
		Path = C.GoString(jinyinzhu.YinZhu)
	}
	var Result int 
	res1, res2 := AncientJinYinZhu_Read(jinyinzhu)
	if which == 0 {
		Result = int(res1)
	} else {
		Result = int(res2)
	}
	file,err := os.Create(Path)
	if err == nil {
		defer file.Close()
		number := Result + int(jinyinzhu.AddNum) + int(howmany)
		_,_ = file.WriteString(strconv.Itoa(number))
	}
}

func main() {}