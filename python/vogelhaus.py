# Author: Nils Geschwinde
# Version: 2.0
# Datum: 21.04.2018

#!/usr/bin/python

# imports
import sys
import pygame as pg
import os
import time
from datetime import datetime

# init the audio mixer with parameters
freq = 44100    # audio CD quality
bitsize = -16   # unsigned 16 bit
channels = 2    # 1 is mono, 2 is stereo
buffer = 2048   # number of buffer samples 
pg.mixer.init(freq, bitsize, channels, buffer)

if len(sys.argv) > 1:

    # try to parse the voulume
    try:
        user_volume = float(sys.argv[1])
    # end programm on error
    except ValueError:
        print ("Volume argument invalid. Please use a float (0.0 - 1.0)")
        pg.mixer.music.fadeout(1000)
        pg.mixer.music.stop()
        raise SystemExit

    # logging information
    print ("Vogelhaus Software gestartet")
    print ("Time: " + str(datetime.now().hour) + ":" + str(datetime.now().minute))
    print("Playing at volume: " + str(user_volume)+ "\n")

    pg.mixer.music.set_volume(user_volume)

    # list of all mp3 files
    audio = None
    for file in os.listdir("../audio"):
        if file.endswith(".mp3"):
            audio = file
    
    if audio != None:
        play_audio(audio)
        time.sleep(.25)


else:
    print("Please specify volume as a float! (0.0 - 1.0)")

# tries to play the given audio file
def play_audio(music_file):
    clock = pg.time.Clock()
    try:
        pg.mixer.music.load(music_file)
        print("Music file {} loaded!".format(music_file))
    except pg.error:
        print("File {} not found! {}".format(music_file, pg.get_error()))
        return

    pg.mixer.music.play()

    #fade in to remove cracking
    for x in range(0,100):
        pg.mixer.music.set_volume(float(x)/100.0)
        time.sleep(.0075)

    while pg.mixer.music.get_busy():
        clock.tick(30)