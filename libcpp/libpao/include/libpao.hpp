#pragma once
#include <iostream>
#include <string>
#include <sstream>
#include <fstream>
#include <vector>

namespace Ancient {
enum class Pao {
    Green,Red,Purple,Black,White,RealRed,Blue,Silver
};
class AncientPao {
public:
    AncientPao(std::string now,std::string all);
    Pao GetNow();
    std::vector<Pao> GetAll();
    int Change(Pao);
    void Add(Pao);
private:
    std::string paonow,paoall;
    std::vector<Pao> ReadAll();
    Pao ReadNow();
};
std::ostream& operator<< (std::ostream& ss,Pao a);
}

