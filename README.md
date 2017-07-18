## Build scripts for my DarkBeast Kernel 

To run the scripts use 

```bash
git clone https://github.com/The-DarkBeast/scripts
cd scripts
bash <device-name>-build.sh
```

After a successful build you will get an option to upload the build directly to your AndroidFileHost account to use that option add this to your ~/.bashrc file 

'export AFH_CREDENTIALS=Your AFH FTP username:Your AFH FTP password'

Directory Structure 

```bash
~/kernel - Where your kernel source is to be placed 
~/toolchain - Where your prebuilt GCC is to be placed 
~/zipper - Where your unzipped recovery flashable zip is to be placed 
```
