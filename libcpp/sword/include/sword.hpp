#pragma once
#include <iostream>
#include <string>
#include <sstream>
#include <fstream>
#include <vector>
#define Swords Sword

namespace Ancient {
enum class Sword {
    Green,Red,Purple,Black,White,RealRed,Blue
};
class AncientSword {
public:
    AncientSword(std::string now,std::string all);
    Swords GetNow();
    std::vector<Swords> GetAll();
    int Change(Sword newsword);
    void Add(Sword addsword);
private:
    std::string swordnow,swordall;
    std::vector<Swords> ReadAll();
    Swords ReadNow();
};
std::ostream& operator<< (std::ostream& ss,Sword a);
}

