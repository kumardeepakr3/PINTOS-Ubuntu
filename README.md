The script ubuntu_pintos.sh installs pintos on Ubuntu 16.04 or Ubuntu 14.04 and sets up your machine to run Pintos

## Commands To Run for Auto-Installation
```
bash pintos_ubuntu.sh
source ~/.bashrc
```

## Manual Installation Steps:
1. ### Install QEMU Simulator
      ```sudo apt-get install qemu```
2. ### Download Pintos source code from [Stanford](http://www.stanford.edu/class/cs140/projects/pintos/pintos.tar.gz)
3. ### Extract pintos.tar.gz
      ```tar -xzvf pintos.tar.gz```
4. ### Edit GDBMACROS
      Open pintos/src/utils/pintos-gdb. Make the variable GDBMACROS point to pintos/src/misc/gdb-macros
      i.e. ```GDBMACROS=/home/....../pintos/src/misc/gdb-macros```.
      Note that it should point to the full path.
5. ### Edit Makefile
      Open pintos/src/utils/Makefile. Change `LDFLAGS` to `LDLIBS`.
6. ### Compile Utils directory
      ```
      cd pintos/src/utils
      make
      ```
7. ### Edit Make.vars
      Open pintos/src/threads/Make.vars and on line 7 change `bochs` to `qemu`
8. ### Compile Threads directory
     ```
     cd pintos/src/threads
     make
     ```
9. ### Edit pintos
      Open pintos/src/utils/pintos and make the following changes:
      - Line 103: Replace `bochs` with `qemu`.
      - Line 259: Replace `kernel.bin` with `/home/.../pintos/src/threads/build/kernel.bin`. Note that we're making it point to full path of kernel.bin
      - Line 623: Replace `qemu` with `qemu-system-x86_64`
10. ### Edit Pintos.pm
      Open pintos/src/utils/Pintos.pm and make the following change:
      - Line 362: Replace `loader.bin` with `/home/.../pintos/src/threads/build/loader.bin`
11. ### Export utils directory path to PATH variable
      Open ~/.bashrc and add this to the last line:
      ```export PATH=$/home/.../pintos/src/utils:$PATH```
12. ### Reload terminal with the new environment variables
      ```source ~/.bashrc```
13. ### Run pintos
      ```pintos run alarm-multiple```
