extern (C) int AncientJuanZeng_GetLevel(int a) {
    if(a < 100) {
        return 1;
    } else if (a < 220) {
        return 2;
    } else if (a < 340) {
        return 3;
    } else if (a < 480) {
        return 4;
    } else {
        return 5;
    }
}
extern (C) int AncientJuanZeng_GetHuangJin(int level) {
    if(level < 4){
        return level * 5;
    } else {
        return level * 6;
    }
}