#!/usr/bin/bash

if ! which fzy > /dev/null; then
        echo "ERROR: fzy is not installed"
        exit -1
fi

readonly X="xinit startx X Xorg"

readonly MENU_OPTS="Poweroff
Halt
Suspend
Hibernate
Reboot"

for x in "${X[@]}"; do
        if ! pidof -xs ${x} > /dev/null; then
                ACTION=$(echo -en "${MENU_OPTS}" | \
                        fzy | \
                        tr [:upper:] [:lower:])

                if [[ -z "${ACTION}" ]]; then
                        echo "ERROR: no option selected"
                        exit 1
                else
                        # TODO: string substitutions here
                        # to change hibernate and suspend
                        # for zzz and ZZZ
                        # OR implement a case statement like:
                        # case ${action} in
                        #     [Pp]oweroff) sudo poweroff;;
                        #     [Ss]uspend) sudo zzz;;
                        #     *) exit 1;;
                        sudo "${ACTION}"
                fi

        fi
done

readonly POWEROFF=$(echo -e "\UF011")    # poweroff button
readonly SUSPEND=$(echo -e "\UF186")     # moon button
readonly HIBERNATE=$(echo -e "\UF0C8")   # square button
readonly REBOOT=$(echo -e "\UF2EA")      # reboot button

# rofi dmenu options explained:
# -p is for the prompt, the default is "dmenu"
# -u is for the nth column be urgent
readonly ROFI_CMD="rofi -dmenu -u 0 -theme pmenu"

ACTION="$(printf "%s\\n%s\\n%s\\n%s" \
        ${POWEROFF} ${SUSPEND} ${HIBERNATE} ${REBOOT} | \
        ${ROFI_CMD})"

case "$ACTION" in
    ${POWEROFF})
        sudo poweroff;;
    ${SUSPEND})
        sudo zzz;;
    ${HIBERNATE})
        sudo ZZZ;;
    ${REBOOT})
        sudo reboot;;
    *)
        exit 1;;
esac

