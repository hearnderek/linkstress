#!/bin/bash

if [ -d "./build" ]
then
    echo rm build dir
    time rm -r "./build"
fi

mkdir "./build"

# echo createmain
# ./src/createmain.py > ./build/main.c
echo createbaselibs

baselibs="A B C D"

for file in $baselibs
do
    echo file: $file
    ./src/createbaselib.pl -h $file > ./build/$file.h
    ./src/createbaselib.pl $file > ./build/$file.c
    clang -c -O3 ./build/$file.c -o ./build/$file.o
    echo ./build/$file.o >> ./build/ofiles.txt 
done

echo file: E
./src/createdependentlib.pl E -h > ./build/E.h
./src/createdependentlib.pl E A B C > ./build/E.c
clang -c -O3 ./build/E.c -o ./build/E.o
echo ./build/E.o >> ./build/ofiles.txt 


echo file: F
./src/createdependentlib.pl F -h > ./build/F.h
./src/createdependentlib.pl F B C D > ./build/F.c
clang -c -O3 ./build/F.c -o ./build/F.o
echo ./build/F.o >> ./build/ofiles.txt 


echo file: main
echo compile main
./src/createdependentmain.pl main E F > ./build/main.c
cat ./build/ofiles.txt | xargs clang -O3 ./build/main.c -o ./build/main && ./build/main
