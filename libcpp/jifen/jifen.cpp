#include <functions/jifen.hpp>
namespace jifen{
int get_from_minutes(long long minutes){
    int tmp=(minutes-10)*10+20;
    if(tmp < 0) return 0;
    else return tmp;
}
int calculate_level(int jifen){
    int tmp=jifen-100;
    if(tmp<0) tmp=0;
    return tmp/200+1;
}
}