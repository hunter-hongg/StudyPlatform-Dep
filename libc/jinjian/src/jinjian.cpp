#include <iostream>
#include "../include/jinjian.h"
#include "../include/rust/rand_rs.hpp"

namespace JinJian {
int GetResult(){
    auto luck = getrnd(0,100); // 左闭右开
    if(0 <= luck && luck < 70) return 1;
    else if(70 <= luck && luck < 75) return 0;
    else return -1;
}
}
