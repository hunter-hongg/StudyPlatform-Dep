#include <iostream>
#include <wuguanpinji.h> 

namespace Ancient{
int WuGuanPinJi::Read() {
    int raw = this -> read_int();
    if ( raw > 9 ) {
        raw = 9;
    } else if ( raw < 1 ) { 
        raw = 9;
    }
    return raw;
}
std::string WuGuanPinJi::ReadStr() {
    std::stringstream ss;
    ss << this -> Read();
    return ss.str();
}
void WuGuanPinJi::LevelUp() {
    if ( Read() == 1 ) { 
        return;
    }
    this -> minusnum( 1 ); //升官，品级减少
}
void WuGuanPinJi::LevelDown() {
    if ( Read() == 9 ) {
        return;
    }
    this -> addnum( 1 ); //贬官，品级增加
}
}
