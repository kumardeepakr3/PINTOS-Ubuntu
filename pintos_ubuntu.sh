#!/bin/bash

# WRITTEN BY DEEPAK KUMAR (kumar.deepak.r3@gmail.com)
# github.com/kumardeepakr3

# Install QEMU Emulator
sudo apt-get install qemu

# REMOVE ALREADY EXISTING PINTOS DIRECTORY
if [-d "./pintos" ]; then
    rm -r pintos
fi

# Download Pintos
wget -nc http://www.stanford.edu/class/cs140/projects/pintos/pintos.tar.gz
tar -xvzf pintos.tar.gz

# Get PintosRootLocation
PINTOSROOT="$(pwd)"
PINTOSUTILS=$PINTOSROOT'/pintos/src/utils/'
PINTOSUTILSNOEND=$PINTOSROOT'/pintos/src/utils'
PINTOSTHREADS=$PINTOSROOT'/pintos/src/threads/'

# clean Utils Folder: $PINTOSUTILS
(cd $PINTOSUTILS ; make clean)

# Clean Threads Folder: $PINTOSTHREADS
(cd $PINTOSTHREADS ; make clean)

# SET GDBMACROS in file $PINTOSROOT/src/utils/pintos-gdb
# TO $PINTOSROOT/src/misc/gdb-macros
STRINGTOREPLACE='\/usr\/class\/cs140\/pintos'
REPLACETOSTRING="${PINTOSROOT//\//\\\/}"
STRINGTOPASS='s/'$STRINGTOREPLACE'/'$REPLACETOSTRING'/g'
sed -i -e $STRINGTOPASS $PINTOSUTILS'pintos-gdb'

# Set LDFLAGS to LDLIBS
sed -i -e 's/LDFLAGS/LDLIBS/g' $PINTOSUTILS'Makefile'


(cd $PINTOSUTILS ; make)

# SET SIMULATOR to qemu in $PINTOSTHREADS/Make.vas
sed -i -e 's/bochs/qemu/g' $PINTOSTHREADS'Make.vars'

# Compile $PINTOSTHREADS
(cd $PINTOSTHREADS ; make)

# EDIT FILE $PINTOSUTILS/pintos
#replace bochs to qemu in line 103
sed -i -e '103s/bochs/qemu/g' $PINTOSUTILS'pintos'

#replace kernel.bin to full path
KERNELBINFULLPATH=$PINTOSTHREADS'build/kernel.bin'
ESCAPEDPATH="${KERNELBINFULLPATH//\//\\\/}"
sed -i -e '259s/kernel.bin/'$ESCAPEDPATH'/g' $PINTOSUTILS'pintos'

#replace qemu to qemu-system-x86_64 on line 623
sed -i -e '623s/qemu/qemu-system-x86_64/g' $PINTOSUTILS'pintos'

#replace loader.bin to full path
LOADERBINFULLPATH=$PINTOSTHREADS'build/loader.bin'
ESCAPEDPATH="${LOADERBINFULLPATH//\//\\\/}"
sed -i -e '362s/loader.bin/'$ESCAPEDPATH'/g' $PINTOSUTILS'Pintos.pm'

#EXPORT $PINTOSUTILS to PATH variable
if [[ ":$PATH:" == *":$PINTOSUTILSNOEND:"* ]]; then
    echo "PATH ALREADY EXISTS"
else
    echo "export PATH=$PINTOSUTILSNOEND:$PATH" >> $HOME/.bashrc
    echo "Updated Path"
fi

source $HOME/.bashrc
