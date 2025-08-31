#pragma once
#include <sstream>
#include <file_password.h>

class PasswordFile: protected file_password
{
public:
    PasswordFile(const std::string& fn, const std::string& p):file_password(fn,p) {}
    std::string read_str()
    {
        auto tmp = this->read_real();
        std::stringstream ss;
        ss << atoi(tmp.c_str());
        return ss.str();
    }
    int read_int()
    {
        auto tmp = this->read_real();
        return atoi(tmp.c_str());
    }
    void addnum(int a)
    {
        if(a<0) return;
        this->add(a);
    }
    void minusnum(int a)
    {
        if(a<0) return;
        this->add(-a);
    }
    bool high(int a)
    {
        return (read_int() >= a);
    }
    bool canminus(int a)
    {
        if(!high(a)) return false;
        minusnum(a);
        return true;
    }
};
