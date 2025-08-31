package main

import (
    "C"
     _"fmt"
)

//export BookShelf_GetShouCangZhi
func BookShelf_GetShouCangZhi(level1, level2, level3 C.int) C.int {
    return level1 * 3 + level2 * 5 + level3 * 8
}

//export BookShelf_GetShouCangLevel
func BookShelf_GetShouCangLevel(shoucangzhi C.int) C.int {
    tmp := (shoucangzhi - 150) / 100
    if tmp < 0 {
        return 0
    } else if tmp > 50 {
        return 50
    } else {
        return tmp
    }
}

func main() {} 
