#!/bin/bash

path = /home/pi/vogelhaus/RPi

# check if the reboot flag file exists. 
# We created this file before rebooting.
if [ ! -f $path/setup/audio_setup_reboot ]; then
    echo "running script for the first time.."

    # run your scripts here
    curl https://raw.githubusercontent.com/adafruit/Raspberry-Pi-Installer-Scripts/master/i2samp.sh >> $path/setup/i2samp.sh
    chmod u+x $path/setup/i2samp.sh
    chmod u+x $path/setup/audio_setup.exp
    ./$path/setup/audio_setup.exp
    # Preparation for reboot
    script="bash $path/setup/audio_setup.sh"
  
    # add this script to zsh so it gets triggered immediately after reboot
    # change it to .bashrc if using bash shell
    echo "$script" >> ~/.bashrc 
  
    # create a flag file to check if we are resuming from reboot.
    sudo touch $path/audio_setup_reboot
    echo "$PWD" >> $path/audio_setup_reboot

    echo "rebooting.."
    # reboot here
    # sudo reboot

else 
    echo "resuming script after reboot.."
  
    # Remove the line that we added in zshrc
    sed -i '/bash/d' ~/.bashrc 
  
    # remove the temporary file that we created to check for reboot
    sudo rm -f $path/audio_setup_reboot

    # continue with rest of the script
    ./$path/setup/audio_setup.exp $path
    rm $path/setup/i2samp.sh

    # reboot again
    # sudo reboot
fi


