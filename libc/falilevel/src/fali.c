#include "fali.h"

int getlevel(int fali){
    int tmp = fali - 150;
    int rle = tmp / 100;
    if(rle<0)return 0;
    if(rle>50)return 50;
    return rle;
}
