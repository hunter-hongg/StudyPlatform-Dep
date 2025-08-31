#!/bin/bash
cd lib
g++ -c ../src/*.cpp -std=c++23 -I../include && \
ar rcs libAncientSword.a *.o && \
rm *.o
