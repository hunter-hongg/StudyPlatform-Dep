#pragma once
#include <fstream>
#include <iostream>
#include <cstdio>
#include <cmath>
#include <sstream>
#include <cstdlib>
#include <unordered_set>
#include <string>

const std::string original = "0123456789";

class file_password
{
public:
    // 构造函数，检查密码是否包含重复字符
    file_password(const std::string& fn, const std::string& p) : file_name(fn)
    {
        std::unordered_set<char> charSet;
        bool validPassword = true;
        for (char c : p) {
            if (charSet.find(c) != charSet.end()) {
                validPassword = false;
                break;
            }
            charSet.insert(c);
        }
        if (validPassword) {
            password = p;
        } else {
            password = "1324096857"; // 使用默认密码
        }
    }

    // 读取文件中的密码，返回读取结果或错误信息
    std::string read_password()
    {
        std::ifstream file1(file_name);
        if (!file1.is_open()) {
            std::ofstream file2(file_name);
            if (!file2.is_open()) {
                return "Failed to create file: " + file_name;
            }
            file2 << password[0];
            file2.close();
        } else {
            file1.close();
        }
        std::ifstream file(file_name);
        if (!file.is_open()) {
            return "Failed to open file: " + file_name;
        }
        std::string line;
        if (!std::getline(file, line)) {
            return "Failed to read from file: " + file_name;
        }
        return line;
    }

    // 将文件中的加密密码转换为真实数字，返回转换结果或 "error"
    std::string read_real()
    {
        std::string x = read_password();
        if (x.find("Failed to") != std::string::npos) {
            return "error";
        }
        std::string r = "";
        for (char c : x) {
            char translated = translateChar(c, password, original);
            if (translated == '\0') {
                return "error";
            }
            r += translated;
        }
        return r;
    }

    // 将数字加密后写入文件，返回操作结果或错误信息
    std::string write(int new_num)
    {
        std::ostringstream ss;
        ss << new_num;
        std::string new_num1 = ss.str();
        std::string r = "";
        for (char c : new_num1) {
            char translated = translateChar(c, original, password);
            if (translated == '\0') {
                return "Invalid number format";
            }
            r += translated;
        }
        std::ofstream file(file_name);
        if (!file.is_open()) {
            return "Failed to open file for writing: " + file_name;
        }
        file << r;
        file.close();
        return ""; // 空字符串表示操作成功
    }

    // 读取文件中的数字，加上指定值后再加密写入文件，返回操作结果或错误信息
    std::string add(int num)
    {
        std::string c = read_real();
        if (c == "error") {
            return "Error reading real value";
        }
        try {
            int x = std::stoi(c) + num;
            return write(x);
        } catch (const std::invalid_argument&) {
            return "Invalid number in file";
        } catch (const std::out_of_range&) {
            return "Number in file is out of range";
        }
    }

protected:
    std::string file_name;
    std::string password;

    // 辅助函数，用于字符转换
    char translateChar(char c, const std::string& from, const std::string& to)
    {
        auto it = from.find(c);
        if (it != std::string::npos) {
            return to[it];
        }
        return '\0';
    }
};
