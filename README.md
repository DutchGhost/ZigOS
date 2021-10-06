```sh
zig.exe build -Dtarget=i386-freestanding
qemu-system-i386.exe -kernel .\zig-out\bin\ZigOS
```