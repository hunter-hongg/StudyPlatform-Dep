#pragma once
#include <string>
#include <functional>

class sharedlib {
public:
    sharedlib();
    ~sharedlib();

    bool Load(const std::string& path);
    void* GetSymbol(const std::string& name);

    template<typename Func>
    std::function<Func> GetFunction(const std::string& name){
        return reinterpret_cast<Func*>(GetSymbol(name));
    }
protected:
    void* m_handle;
}

