#!/bin/bash

MYPATH="/home/pi/vogelhaus/RPi"

# check if the reboot flag file exists. 
# We created this file before rebooting.
if [ ! -f "$MYPATH/setup/audio_setup_reboot" ]; then
    echo "running script for the first time.."

    # RTC Setup
    # Audio Setup
    curl https://raw.githubusercontent.com/adafruit/Raspberry-Pi-Installer-Scripts/master/i2samp.sh >> "$MYPATH/setup/i2samp.sh"
    chmod u+x "$MYPATH/setup/i2samp.sh"
    chmod u+x "$MYPATH/setup/audio_setup.exp"
    expect "$MYPATH/setup/audio_setup.exp" $MYPATH

    # Preparation for reboot
    script="bash $MYPATH/setup/audio_setup.sh"
  
    # add this script to bashrc so it gets triggered immediately after reboot
    echo "$script" >> ~/.bashrc 
    # create a flag file to check if we are resuming from reboot.
    sudo touch "$MYPATH/audio_setup_reboot"
    echo "rebooting.."
    # sudo reboot

else 
    echo "resuming script after reboot.."
  
    # Remove the line that we added in zshrc
    sed -i '/bash/d' ~/.bashrc 
    # remove the temporary file that we created to check for reboot
    sudo rm -f "$MYPATH/audio_setup_reboot"
    # Audio Setup part 2
    expect "$MYPATH/setup/audio_setup.exp" $MYPATH
    rm "$MYPATH/setup/i2samp.sh"
    # sudo reboot
fi


