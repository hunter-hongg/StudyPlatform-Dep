#pragma once 
#include <vector>
namespace WuGuanChuZheng{
enum class Choices {
    JinGong, 
    XiuZheng, 
    FangShou, 
    TouXi, 
};
Choices GetChoice(int Other, int Self);
std::vector<int> GetResult(Choices a, Choices b);
}

