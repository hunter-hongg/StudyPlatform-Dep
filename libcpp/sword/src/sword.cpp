#include <sword.hpp>
#include <algorithm>
#include <unordered_set>

namespace Ancient {
AncientSword::AncientSword(std::string now,std::string all){
    swordnow = now;
    swordall = all;
}
Sword AncientSword::GetNow(){return ReadNow();}
std::vector<Sword> AncientSword::GetAll(){return ReadAll();}
Sword AncientSword::ReadNow(){
    std::ofstream tmpq(swordnow,std::ios::app);
    tmpq.close();
    std::ifstream read(swordnow);
    std::string a;
    read >> a;
    read.close();
    int tmp = atoi(a.c_str());
    if(tmp < 0 || tmp > 6) return Sword::Green;
    return static_cast<Sword>(tmp);
}
std::vector<Sword> AncientSword::ReadAll(){
    std::ofstream tmp(swordall,std::ios::app);
    tmp.close();
    std::ifstream read(swordall);
    std::vector<std::string> alla;
    std::string ttmp;
    while(getline(read,ttmp,',')){alla.push_back(ttmp);}
    std::vector<Sword> rt;
    for(const auto& i : alla){
        int ttp = atoi(i.c_str());
        if(ttp<0 || ttp>6) ttp = 0;
        rt.push_back(static_cast<Sword>(ttp));
    }
    std::unordered_set<Sword> rts;
    for(const auto& i : rt){rts.insert(i);}
    std::vector<Sword> rtt(rts.begin(),rts.end());
    return rtt;
}
int AncientSword::Change(Sword newsword){
    auto tmp = ReadAll();
    if(std::find(tmp.begin(),tmp.end(),newsword) == tmp.end()) return 1;
    std::ofstream out(swordnow);
    out << static_cast<int>(newsword);
    return 0;
}
void AncientSword::Add(Sword addsword){
    std::ofstream out(swordall,std::ios::app);
    out << ',' << static_cast<int>(addsword);
}
std::ostream& operator<< (std::ostream& ss,Sword a){
    switch(a){
        case Sword::Green:return ss << "青剑";
        case Sword::Red:return ss << "赤剑";
        case Sword::Purple:return ss << "紫剑";
        case Sword::Black:return ss << "黑剑";
        case Sword::White:return ss << "白剑";
        case Sword::RealRed:return ss << "红剑";
        case Sword::Blue:return ss << "蓝剑";
    default:return ss << "紫剑";
    }
}
}
