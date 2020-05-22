#!/usr/bin/mksh

#Author: Kelves C.
#License: Public Domain
#Version: 0.5.4-beta
#Description: shows system shutdown options and executed the selected one

if ! pidof -xs startx 2>&1 1> /dev/null; then
    options="Poweroff\nHalt\nSuspend\nHibernate\nReboot\n"
    if which fzy > /dev/null; then
        action=$(echo -en "$options" | fzy)
        case $action in
            [Pp]oweroff) sudo poweroff;;
            [Ss]uspend) sudo zzz;;
            *) exit 1;;
        esac
    fi
fi


POWEROFF=$(echo -e "\UF011")    # poweroff button
SUSPEND=$(echo -e "\UF186")     # moon button
HIBERNATE=$(echo -e "\UF0C8")   # square button
REBOOT=$(echo -e "\UF2EA")      # reboot button

# rofi dmenu options explained:
# -p is for the prompt, the default is "dmenu"
# -u is for the nth column be urgent
ROFI_CMD="rofi -dmenu -u 0 -a 1 -theme pmenu"

action="$(printf "%s\\n%s\\n%s\\n%s" $POWEROFF $SUSPEND $HIBERNATE $REBOOT | \
    $ROFI_CMD)"

case "$action" in
    $POWEROFF)
        sudo poweroff;;
    $SUSPEND)
        sudo zzz;;
    $HIBERNATE)
        sudo ZZZ;;
    $REBOOT)
        sudo reboot;;
    *)
        exit 1;;
esac

