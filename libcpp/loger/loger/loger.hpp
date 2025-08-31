#pragma once
#include <sstream>
#include <fstream>
#include <memory>

class loger
{
public:
    loger(std::string logfile);
    template<typename T>
    loger& operator<< (T const& t)
    {
        buffer << t;
        return *this;
    }
    void flush();
    ~loger();
protected:
    std::ofstream ofs;
    std::stringstream buffer;
};
typedef loger & ( * PEndlFunction)(loger&);
loger& operator<< (loger& log, PEndlFunction pfunc);
loger& Endline(loger& log);

#ifdef RELEASE
#define logfile std::cout
#define Endline std::endl
#else
static loger logfile("log.log");
#endif
