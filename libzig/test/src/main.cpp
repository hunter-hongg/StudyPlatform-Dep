#include <iostream>
extern "C"{
#include "../include/guwancha.h"
}

int main() {
    auto tmp = GuWanChaFiles_Make("d.txt","e.txt",1234);
    std::cout << GuWanChaFiles_Read(tmp, 0) << " " << GuWanChaFiles_Read(tmp, 1) << std::endl;
    GuWanChaFiles_Add(tmp, 0, 5);
    std::cout << GuWanChaFiles_Read(tmp, 0) << " " << GuWanChaFiles_Read(tmp, 1) << std::endl;
    GuWanChaFiles_Add(tmp, 1, 10);
    std::cout << GuWanChaFiles_Read(tmp, 0) << " " << GuWanChaFiles_Read(tmp, 1) << std::endl;
    GuWanChaFiles_Free(tmp);
    return 0;
}
