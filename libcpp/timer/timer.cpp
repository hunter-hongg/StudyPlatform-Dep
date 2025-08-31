#include <timer/timer.hpp>

int timer::start(){
    if(!is_start){
        is_start = 1;
        start_time = clock::now();
        how_long = std::chrono::milliseconds(0);
        return 0;
    }
    return -1;
}
int timer::stop(){
    if(!is_start){
        return -1;
    }
    point end_time = clock::now();
    how_long = end_time - start_time;
    is_start = 0;
    return 0;
}
long long timer::get_milliseconds(){
    return static_cast<long long>(std::chrono::duration_cast<std::chrono::milliseconds>(how_long).count());
}
long long timer::get_seconds(){
    return static_cast<long long>(std::chrono::duration_cast<std::chrono::seconds>(how_long).count());
}
long long to_minutes(long long seconds){
    return seconds/60;
}