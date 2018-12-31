# Vogelhaus
## Informationen
Eine kleine Vogelanlockstation im Auftrag der [Natur AG Bramsche](https://naturagbramsche.blog/)
### Anforderungen
### Weiterführende Links
[Blogartikel](#) zu diesem Projekt  
[Video](#) zu diesem Projekt
## Anleitung
### 1. Hardware
---
#### Ohne Akku
- [Rasperry Pi]()
- [Adafruit I2S 3W Class D Amplifier Breakout - MAX98357A](https://www.adafruit.com/product/3006)
- [DS3231 RTC Modul LIR2032]()
- [Jumper Wires]()
- [Netzteil]()
- [MicroSD - Karte]()
- [Lautsprecher 4 Ohm 3 Watt]()
- Ein Gehäuse um die Hardware vor Witterung zu schützen
---
#### Mit Akku
- ~~Netzteil~~
- ~~RTC Modul~~ (ist im Sleepy Pi verbaut)
- [Sleepy Pi 2]()
- [Blei Akku 12V 50Ah]()
- [evtl. Ladegerät für den Akku]()
- [Flachsteckerkabel]()
---
### 2. Aufbau
---
#### Breakout/Verstärker
##### Zusammenbau
siehe [Adafruits Assembly Guide](https://learn.adafruit.com/adafruit-max98357-i2s-class-d-mono-amp/assembly)
##### Verkabelung
- **VIN** an Raspberry **Pi 5V**
- **GND** an Raspberry **Pi GND**
- **DIN** an Raspberry **Pi #21**
- **BCLK** an Raspberry **Pi #18**
- **LRCLK** an Raspberry **Pi #19**  
Weitere Informationen: [Adafruits Wiring Guide](https://learn.adafruit.com/adafruit-max98357-i2s-class-d-mono-amp/raspberry-pi-wiring)
---
#### RTC Modul (ohne Akku)
- **GND** an Raspberry **Pi GND**
- **VCC** an Raspberry **Pi 3.3V**
- **SDA** an Raspberry **Pi #03**  
- **SCL** an Raspberry **Pi #05**   
Weitere Informationen: [In diesem Blog](https://www.raspberrypi-spy.co.uk/2015/05/adding-a-ds3231-real-time-clock-to-the-raspberry-pi/)
---
#### SleepyPi (mit Akku)
Den SleepyPi einfach du den GPIO Header des RaspberryPi's aufstecken
---
### 3. Einrichtung
Befehl `sudo raspi-config` eingeben  
#### Tastaturlayout ändern (optional)
`4. Localisation Options` auswählen
`I3 Change Keyboard Layout` auswählen
Danach das passende Tastaurlayout auswählen
#### Passwort ändern (optional)
`1. Change User Password` auswählen  
Mit `OK` bestätigen und neues Passwort eingeben
###Zeitzone ändern
`4. Localisation Options` auswählen
`I Change Timezone` auswählen
Danach die passende Zeitzone auswählen
#### SSH aktivieren
`5. Interfacing Options` auswählen  
`P2 SSH` auswählen und mit `Yes` bestätigen
#### I2C aktivieren
`5. Interfacing Options` auswählen  
`P5 I2C` auswählen und mit `Yes` bestätigen
#### Git einrichten
Git mit `sudo apt-get install git` installieren  
Repository mit `git clone https://github.com/Nils0xFF/vogelhaus.git` in das user Verzeichniss kopieren
#### Grundsetup
In das Verzeichnis `vogelhaus/RPi/setup` navigieren  
Mit `chmod u+x inital_setup.sh` die Rechte zum ausführen erteilen  
`./inital_setup.sh` ausführen um alle nötigen Pakete zu installieren
#### Audiowiedergabe
In das Verzeichnis `vogelhaus/RPi/setup` navigieren  
Mit `chmod u+x audio_setup.sh` die Rechte zum ausführen erteilen  
`./audio_setup.sh` ausführen um die Audiokonfiguration zu beenden  
[Adafruits Installations Guide](https://learn.adafruit.com/adafruit-max98357-i2s-class-d-mono-amp/raspberry-pi-usage)
#### Zeiteinstellungen
`sudo nano /etc/rc.local` öffnen  
```
echo ds1307 0x68 > /sys/class/i2c-adapter/i2c-1/new_device
hwclock -s
```  
vor `exit 0` einfügen  
Den Pi mit `sudo reboot` neustarten
### 4. Software
#### Funktionsweise
Python Script das alle MP3 Datein aus dem Audio Verzeichis abspielt
#### Automatischer Aufruf mit crontab
minute | hour | dayOfMonth | month | dayOfWeek | command
--- | --- | --- | --- | --- | ---
0 | 6 | * | * | * | python {Pfad zum Script}
0 | 12 | * | * | * | python {Pfad zum Script}
0 | 20 | * | * | * | python {Pfad zum Script}
### 5. Energie sparen
#### HDMI abschalten


