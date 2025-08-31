#pragma once
#include <sstream>
#include <PasswordFile.hpp>

namespace Ancient {
class WuGuanPinJi : protected PasswordFile {
public: 
    WuGuanPinJi(std::string file, std::string pwd): PasswordFile(file, pwd) {}
    int Read();
    std::string ReadStr();
    void LevelUp();
    void LevelDown();
};
}
