# 3dsnix
This work-in-progress LovePotion app allows you to use a 3DS to control your Switch via network thanks to [sys-botbase](https://github.com/olliz0r/sys-botbase)
## Initial Requirements
- Nintendo 3DS with Luma3DS
- Nintendo Switch with Atmosphere
## Install
- For the Switch, download the latest [sys-botbase](https://github.com/olliz0r/sys-botbase/releases) sysmodule and extract the archive to the root of SD card
- Check if the sysmodule is installed by rebooting your console - you should see the home button glow on boot if its installed
- For the 3DS, download the latest [LovePotion](https://github.com/lovebrew/lovepotion/releases) release for Nintendo 3DS and put `lovepotion.3dsx` in `/3ds/lovepotion`
- Create a folder `/3ds/lovepotion/game` and put `main.lua` in it
- Launch LovePotion via Homebrew Launcher
- On text prompt, input the Switch's IP address (see via System Settings > Internet)
- After a while, the 3DS should connect to the Switch and accept inputs
## Current State
- 3DS shows up as a Pro Controller by default
- D-Pad, ABXY and L/R buttons are supported
- Minimal interface to check the stick state and last button change
## TO-DO
In an order of somewhat importance
- Sticks and ZL/ZR support
- Pretty UI
- Error handling
- Quick reconnect
- Spoof 3DS as another controller (Sideways Joy-Con, for example)
- Maybe a Nintendo DS version? Or at least rewrite this in C or something, who knows.
