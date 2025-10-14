#include <iostream>
#include <vector>
#include "ChuZheng.hpp"
#define chojin Choices::JinGong 
#define chofang Choices::FangShou
#define choxiu Choices::XiuZheng
#define chotou Choices::TouXi
using namespace WuGuanChuZheng;

std::string choices_to_string(Choices t) {
    switch(t){
        case Choices::JinGong: return "Choices::JinGong"; break; 
        case Choices::FangShou: return "Choices::FangShou"; break;
        case Choices::XiuZheng: return "Choices::XiuZheng"; break;
        case Choices::TouXi: return "Choices::TouXi"; break;
        default: return "Unknown Choice"; break;
    }
}
int out_thing(Choices a, Choices b) {
    std::cout << "--------------------------------------" << std::endl;
    std::cout << "a: " << choices_to_string(a) << std::endl;
    std::cout << "b: " << choices_to_string(b) << std::endl;
    std::cout << "result: " << std::endl;
    auto res = GetResult(a, b);
    std::cout << "a + (" << res[0] << ") b + (" << res[1] << ") " << std::endl;
    return 0;
}
int main() {
    out_thing(chojin, chojin);
    out_thing(chojin, choxiu);
    out_thing(chojin, chofang);
    out_thing(chojin, chotou);
    out_thing(choxiu, chojin);
    out_thing(choxiu, choxiu);
    out_thing(choxiu, chofang);
    out_thing(choxiu, chotou);
    out_thing(chofang, chojin);
    out_thing(chofang, choxiu);
    out_thing(chofang, chofang);
    out_thing(chofang, chotou);
    out_thing(chotou, chojin);
    out_thing(chotou, choxiu);
    out_thing(chotou, chofang);
    out_thing(chotou, chotou);
    /*
    std::cout << "test1: " << choices_to_string(
        GetChoice(255, 500)) << std::endl;
    std::cout << "test2: " << choices_to_string(
        GetChoice(255, 250)) << std::endl;
    std::cout << "test3: " << choices_to_string(
        GetChoice(255, 50)) << std::endl;
    */
}
