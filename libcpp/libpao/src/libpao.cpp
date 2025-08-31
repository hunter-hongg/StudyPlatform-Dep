#include <libpao.hpp>
#include <algorithm>
#include <unordered_set>

namespace Ancient {
AncientPao::AncientPao(std::string now,std::string all):
    paonow(now),
    paoall(all){}

Pao AncientPao::GetNow(){return ReadNow();}
std::vector<Pao> AncientPao::GetAll(){return ReadAll();}
Pao AncientPao::ReadNow(){
    std::ofstream tmpq(paonow,std::ios::app);
    tmpq.close();
    std::ifstream read(paonow);
    std::string a;
    read >> a;
    read.close();
    int tmp = atoi(a.c_str());
    if(tmp < 0 || tmp > 7) return Pao::Green;
    return static_cast<Pao>(tmp);
}
std::vector<Pao> AncientPao::ReadAll(){
    std::ofstream tmp(paoall,std::ios::app);
    tmp.close();
    std::ifstream read(paoall);
    std::vector<std::string> alla;
    std::string ttmp;
    while(getline(read,ttmp,',')){alla.push_back(ttmp);}
    std::vector<Pao> rt;
    for(const auto& i : alla){
        int ttp = atoi(i.c_str());
        if(ttp<0 || ttp>7) ttp = 0;
        rt.push_back(static_cast<Pao>(ttp));
    }
    std::unordered_set<Pao> rts;
    for(const auto& i : rt){rts.insert(i);}
    std::vector<Pao> rtt(rts.begin(),rts.end());
    return rtt;
}
int AncientPao::Change(Pao newpao){
    auto tmp = ReadAll();
    if(std::find(tmp.begin(),tmp.end(),newpao) == tmp.end()) return 1;
    std::ofstream out(paonow);
    out << static_cast<int>(newpao);
    return 0;
}
void AncientPao::Add(Pao addpao){
    std::ofstream out(paoall,std::ios::app);
    out << ',' << static_cast<int>(addpao);
}
std::ostream& operator<< (std::ostream& ss,Pao a){
    switch(a){
        case Pao::Green:return ss << "青袍";
        case Pao::Red:return ss << "赤袍";
        case Pao::Purple:return ss << "紫袍";
        case Pao::Black:return ss << "黑袍";
        case Pao::White:return ss << "白袍";
        case Pao::RealRed:return ss << "红袍";
        case Pao::Blue:return ss << "蓝袍";
        case Pao::Silver:return ss << "银袍";
        default:return ss << "紫袍";
    }
}
}
