#include <iostream>
#include <libFFI_Go_AncientJinYinZhu.h>

int main() {
    auto tmp = AncientJinYinZhu_Create("a.txt","b.txt",1234);
    std::cout << tmp->AddNum << " " << tmp->JinZhu << " " << tmp->YinZhu << std::endl;
    auto a = AncientJinYinZhu_Read(tmp);
    int a1 = a.r0;
    int a2 = a.r1;
    std::cout << a1 << " " << a2 << std::endl;
    AncientJinYinZhu_Write(tmp,0,25);
    AncientJinYinZhu_Write(tmp,1,40);
    a = AncientJinYinZhu_Read(tmp);
    a1 = a.r0;
    a2 = a.r1;
    std::cout << a1 << " " << a2 << std::endl;
    return 0;
}
