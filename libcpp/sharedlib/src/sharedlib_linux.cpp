#include <sharedlib.hpp>
#include <dlfcn.h>

sharedlib::sharedlib() : m_handle(nullptr) {}
sharedlib::~sharedlib() {
    if (m_handle) dlclose(m_handle);
}
