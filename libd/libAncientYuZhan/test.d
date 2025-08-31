import std.stdio;
import std.string;
import core.stdc.stdlib;

extern (C) struct YuZhan {
    char* file;
    int AddNum;
}
extern (C) YuZhan* YuZhan_Create(char* file, int AddNum) {
    YuZhan* tmp = cast(YuZhan*)malloc(YuZhan.sizeof);
    tmp.file=file;
    tmp.AddNum=AddNum;
    return tmp;
}
extern (C) void YuZhan_Free(YuZhan* yuzhan) {
    free(yuzhan);
    return;
}
extern (C) int YuZhan_Get(YuZhan* yuzhan) {
    try {
        auto file = File(fromStringz(yuzhan.file), "r");
        string firstline = file.readln();
        file.close();
        int firstline_int = atoi(firstline.toStringz);
        int realnum = firstline_int - yuzhan.AddNum;
        if(realnum < 0){
            return 0;
        } else {
            return realnum;
        }
    } catch (Exception e) {
        auto file = File(fromStringz(yuzhan.file), "w");
        file.writeln(yuzhan.AddNum);
        file.close();
        return 0;
    }
}

extern (C) void YuZhan_Write(YuZhan* yuzhan, int addnum){
    int now = YuZhan_Get(yuzhan);
    auto file = File(fromStringz(yuzhan.file),"w");
    file.writeln(yuzhan.AddNum + now + addnum);
    return;
}
