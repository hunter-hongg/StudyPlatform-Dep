#include <shengguan.h>

namespace ShengGuanSpace{
bool ShengGuan(int now, int zhengji) {
    return (zhengji > (50 + (10 - now) * 5));
}
int UseZhengJi(int now) {
    return (50 + (10 - now) * 5);
}
}
