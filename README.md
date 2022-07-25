# pi-pico-rubber-ducky

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![MIT License][license-shield]][license-url]
[![Issues][issues-shield]][issues-url]


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




[contributors-shield]: https://img.shields.io/github/contributors/nzkoxzu/pi-pico-rubber-ducky.svg?style=for-the-badge&logo=appveyor&color=success
[contributors-url]: https://github.com/nzkoxzu/pi-pico-rubber-ducky/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/nzkoxzu/pi-pico-rubber-ducky.svg?style=for-the-badge&logo=appveyor&color=yellow
[forks-url]: https://github.com/nzkoxzu/pi-pico-rubber-ducky/network/members
[license-shield]: https://img.shields.io/github/license/nzkoxzu/pi-pico-rubber-ducky.svg?style=for-the-badge&logo=appveyor&color=orange
[license-url]: https://github.com/nzkoxzu/pi-pico-rubber-ducky/blob/master/LICENSE.txt
[issues-shield]: https://img.shields.io/github/issues/nzkoxzu/pi-pico-rubber-ducky.svg?style=for-the-badge&logo=appveyor&color=red
[issues-url]: https://github.com/nzkoxzu/pi-pico-rubber-ducky/issues
