#!/usr/bin/sh
######################### DESCRIPTION ###############################
# To remap a key xmodmap -e "keycode NUMBER = KEYSYMNAME ...
# Where NUMBER is the key's number and KEYSYMNAME is/are the new value(s)
# first keysymname: when no modifier key is pressed with key
# second keysymname: when shift is pressed in conjunction with key
# third keysymname: when mode_switch (control) in conjunction with key
# fourth keysymname: when mode_switch and shift are pressed with key

# Sets the base keyborad layout to br-abnt2
setxkbmap br -variant abnt2

xmodmap -e "clear lock"
#Menu(135) -> Super_L(133)
#xmodmap -e "keycode 135 = Super_L"
xmodmap -e "keysym Menu = Super_L"
#??: NoSymbol(97) -> slash(47) question exclam(10)
xmodmap -e "keycode 97 = slash question exclam"
#Alt_GR(108) -> Alt_l (64)
xmodmap -e "keycode 108 = Alt_L"
#xmodmap -e "keysym ISO_Level3_Shift = Alt_R"
#xmodmap -e "keycode 64 = Alt_R Meta_L"
#Caps_Lock(66) -> Escape(9)
#xmodmap -e "keycode 66 = Escape"
xmodmap -e "keysym Caps_Lock = Escape"
#dead_acute(34) -> bar(94) backslash(94)
#xmodmap -e "keycode 34 = bar backslash"
xmodmap -e "keysym dead_acute = bar backslash"
#ccedilla(47) -> slash(47) backslash(94)
xmodmap -e "keysym ccedilla = slash backslash"
#Print       -> PageUP()
xmodmap -e "keysym Print = Prior"
#pause(127) -> PageDOWN()
#xmodmap -e "keycode 127 ="
xmodmap -e "keysym Pause = Next"
#insert(118) -> Return(36)
#xmodmap -e "keycode 118 = Return"
xmodmap -e "keysym Insert = Return"

# xset r enables the new values' repetition
xset r 108
xset r 34
xset r 66
xset r 64

exit 0

