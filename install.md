## Installation Procedure

At the begin  some development environment setup
is necessary.
Our training will use 4 software packages:
- [VIM](https://www.vim.org/) text editor
- [Arm](https://developer.arm.com/tools-and-software/gnu-toolchain) toolchain for embeded environment
- [Git](https://git-scm.com/) distributed version control system
- [Renode](https://antmicro.com/platforms/renode/) emulator of hardware 

```
windows:
winget install Arm.GnuArmEmbeddedToolchain
winget install Arm.GnuArmEmbeddedToolchain -i -l c:\opt\arm

debian:
sudo apt update
sudo apt install gcc-arm-none-eabi binutils-arm-none-eabi


macOS:
brew install --cask gcc-arm-embedded

winget uninstal vim.vim
winget install -e --id vim.vim -i -l c:\opt\vim

winget install -e --id Git.Git -l c:\opt\git
winget install -e --id Renode.Renode -i -l c:\opt\renode
 
```
