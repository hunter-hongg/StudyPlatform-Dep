extern "C"{
#include <test.h>
}
#include <iostream>

int main() {
    std::cout << AncientJuanZeng_GetLevel(5) << " " << AncientJuanZeng_GetLevel(130) << std::endl;
    std::cout << AncientJuanZeng_GetHuangJin(3) << " "
              << AncientJuanZeng_GetHuangJin(4) << " "
              << AncientJuanZeng_GetHuangJin(5) << std::endl;
    return 0;
}
