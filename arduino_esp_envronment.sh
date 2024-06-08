#!/bin/bash
# List of packages that need to be installed to the system
# esptool
# CH341 driver

fail(){
        echo "ERROR: $1"
        exit 1
}

_check_dependecies(){
        readonly DEPENDECIES="git"
        for dep in "${DEPENDECIES}"; do
                if ! command -v $dep 2&>1 > /dev/null; then
                        fail "${dep} is not installed."
                fi
        done
}

_install_ch341_driver(){
        readonly _ch34x_module=$(lsmod | awk '$1~/ch34/{print $1}')
        # TODO: if the above string is null then we should proceed to verify for flag
        if [ -n ${_CH34X_MODULE} ]; then
                kernel_contains_ch341_flag=$(cat /boot/config-$(uname -r) | grep -i "CH341")
        fi

        # TODO: if flag is not set, must exit with error message
        if [ -n "${kernel_contains_ch341_flag}" ]; then
                fail "kernel was not compiled with ch341 flag."
        fi

        mkdir /usr/src
        cd /usr/src
        git clone -b https://github.com/WCHSoftGroup/ch341ser_linux.git
        cd ch341ser_linux
        make

        #cd /usr/src
        #git clone -b ubuntu https://github.com/juliagoda/CH341SER.git
        #cd CH341SER
        #git clone https://github.com/WCHSoftGroup/ch341ser_linux.git
        #cd ch341ser_linux

        #make

        echo "_install_ch341_driver loaded."
}

_install_esptool(){
        echo "_install_esptool loaded."
}

_install_arduino_cli(){
        # source: https://github.com/arduino/arduino-cli
        arduino_cli_script="https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh"
        curl -fsSL "${arduino_cli_script}" | sh;

        if command -v arduino-cli; then
                esp32_config=https://raw.githubusercontent.com/espressif/arduino-esp32/gh-pages/package_esp32_index.json
                cat <<EOF
arduino-cli installed successfully.
Consider using alias ac='arduino-cli'.
Consider adding arduino-cli to your PATH.
Also, use arduino-cli config init and add the following to the file:
board_manager:
  additional_urls:
        - ${esp32_config}
And the run:
arduino-cli core update-index
arduino-cli board install
arduino-cli core install esp32:esp32
arduino-cli board list

EOF
        fi

}

run(){
        _check_dependecies
}

run
