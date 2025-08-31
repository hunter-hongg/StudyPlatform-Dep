#include "loger/loger.hpp"

loger::loger(std::string logfile)
{
    ofs.open(logfile);
};
void loger::flush()
{
    ofs << buffer.str();
    buffer.str("");
    buffer.clear();
}
loger::~loger()
{
    flush();
    ofs.close();
}
loger& operator<< (loger& log, PEndlFunction pfunc)
{
    pfunc(log);
    return log;
}
loger& Endline(loger& log)
{
    log << "\n";
    log.flush();
    return log;
}
