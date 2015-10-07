#! /bin/bash

echo 'int main(){}' > dummy.c
cc dummy.c
readelf -l a.out | grep ': /tools'
rm -v dummy.c a.out
