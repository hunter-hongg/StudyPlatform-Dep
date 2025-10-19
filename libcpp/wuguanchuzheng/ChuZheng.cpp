#include "ChuZheng.hpp"
#include <vector>
#include <cstdlib>
#include <ctime>

namespace WuGuanChuZheng {
std::vector<int> GetResult(Choices a, Choices b){
    srand(time(0));
    if (( a == Choices::JinGong ) && (b == Choices::JinGong)){
        return std::vector<int>({((-30)+rand()%11-5),((-30)+rand()%11-5)});
    } else if ( 
        ((a == Choices::JinGong) && (b == Choices::XiuZheng)) || 
        ((a == Choices::XiuZheng) && (b == Choices::JinGong))) {
        if ( a == Choices::JinGong ) {
            return std::vector<int>({
                ((-10)+rand()%11-5), 
                ((-30)+rand()%11-5), 
            }); 
        } else {
            return std::vector<int>({
                ((-30)+rand()%11-5), 
                ((-10)+rand()%11-5), 
            }); 
        }
    } else if ( 
        ((a == Choices::JinGong) && (b == Choices::FangShou)) ||
        ((a == Choices::FangShou) && (b == Choices::JinGong))) {
        if ( a == Choices::JinGong ) {
            return std::vector<int>({
                ((-35)+rand()%11-5), 
                ((-5)+rand()%11-5), 
            }); 
        } else {
            return std::vector<int>({
                ((-5)+rand()%11-5), 
                ((-35)+rand()%11-5), 
            }); 
        }
    } else if (
        ((a == Choices::JinGong) && (b == Choices::TouXi)) ||
        ((a == Choices::TouXi) && (b == Choices::JinGong))) {
        if ( a == Choices::JinGong ) {
            return std::vector<int>({
                ((-20)+rand()%11-5), 
                ((-40)+rand()%11-5), 
            }); 
        } else {
            return std::vector<int>({
                ((-40)+rand()%11-5), 
                ((-20)+rand()%11-5), 
            }); 
        }
    } else if ((a == Choices::XiuZheng) && (b == Choices::XiuZheng)) {
        return std::vector<int>({
            ((20)+rand()%11-5), 
            ((20)+rand()%11-5), 
        }); 
    } else if (
        ((a == Choices::XiuZheng) && (b == Choices::FangShou)) ||
        ((a == Choices::FangShou) && (b == Choices::XiuZheng))) {
        if ( a == Choices::XiuZheng ) {
            return std::vector<int>({
                ((30)+rand()%11-5), 
                ((-50)+rand()%11-5), 
            }); 
        } else {
            return std::vector<int>({
                ((-50)+rand()%11-5), 
                ((30)+rand()%11-5), 
            }); 
        }
    } else if (
        ((a == Choices::XiuZheng) && (b == Choices::TouXi)) ||
        ((a == Choices::TouXi) && (b == Choices::XiuZheng))) {
        if ( a == Choices::XiuZheng ) {
            return std::vector<int>({
                ((-30)+rand()%11-5), 
                ((-5)+rand()%11-5), 
            }); 
        } else {
            return std::vector<int>({
                ((-5)+rand()%11-5), 
                ((-30)+rand()%11-5), 
            }); 
        }
    } else if ((a == Choices::FangShou) && (b == Choices::FangShou)) {
        return std::vector<int>({
            ((-20)+rand()%11-5), 
            ((-20)+rand()%11-5), 
        }); 
    } else if (
        ((a == Choices::FangShou) && (b == Choices::TouXi)) ||
        ((a == Choices::TouXi) && (b == Choices::FangShou))) {
        if ( a == Choices::FangShou ) {
            return std::vector<int>({
                ((5)+rand()%11-5), 
                ((-30)+rand()%11-5), 
            }); 
        } else {
            return std::vector<int>({
                ((-30)+rand()%11-5), 
                ((5)+rand()%11-5), 
            }); 
        }
    } else if ((a == Choices::TouXi) && (b == Choices::TouXi)) {
        return std::vector<int>({
            ((-40)+rand()%11-5), 
            ((-40)+rand()%11-5), 
        }); 
    }
    return std::vector<int>({
        0, 0
    });
}
Choices GetChoice(int Other, int Self){
    auto other = Other;
    auto self = Self;
    auto cha = self - other;
    srand(time(0));
    if ( cha < 0 ) { cha = -cha; }
    if ( self > other ) {
        auto t = rand()%10;
        if ( t < 4 ) { return Choices::JinGong; }
        else if ( t < 6 ) { return Choices::XiuZheng; }
        else { return Choices::TouXi; }
    } else if (cha < 90) {
        auto t = rand()%10;
        if ( t < 2 ) { return Choices::JinGong; }
        else if (t < 4 ) { return Choices::XiuZheng; }
        else if (t < 7 ) { return Choices::FangShou; }
        else { return Choices::TouXi; }
    } else {
        auto t = rand()%10;
        if ( t < 2 ) { return Choices::JinGong; }
        else if ( t < 6 ) { return Choices::FangShou; }
        else { return Choices::XiuZheng; }
    }
}
}
