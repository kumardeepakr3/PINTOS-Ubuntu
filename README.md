## Manual Installation Steps:
1. ### Install QEMU Simulator
      ```sudo apt-get install qemu```
1. ### Edit GDBMACROS
      Open pintos/src/utils/pintos-gdb. Make the variable GDBMACROS point to pintos/src/misc/gdb-macros
      i.e. ```GDBMACROS=/home/....../pintos/src/misc/gdb-macros```.
      Note that it should point to the full path.
1. ### Compile Utils directory
      ```
      cd pintos/src/utils
      make
      ```
1. ### Compile Threads directory
     ```
     cd pintos/src/threads
     make
     ```
1. ### Edit pintos
      Open pintos/src/utils/pintos and make the following changes:
      - Line 259: Replace `kernel.bin` with `/home/.../pintos/src/threads/build/kernel.bin`. Note that we're making it point to full path of kernel.bin
1. ### Edit Pintos.pm
      Open pintos/src/utils/Pintos.pm and make the following change:
      - Line 362: Replace `loader.bin` with `/home/.../pintos/src/threads/build/loader.bin`
1. ### Export utils directory path to PATH variable
      Open ~/.bashrc and add this to the last line:
      ```export PATH=/home/.../pintos/src/utils:$PATH```
1. ### Reload terminal with the new environment variables
      ```source ~/.bashrc```
1. ### Run pintos
      ```pintos run alarm-multiple```
