# TWRP Device configuration for Motorola Edge Plus

## Device specifications

Basic   | Spec Sheet
-------:|:-------------------------
CPU     | Octa-core (1x2.84 GHz Kryo 585 & 3x2.42 GHz Kryo 585 & 4x1.8 GHz Kryo 585)
CHIPSET | Qualcomm SM8250 Snapdragon 865
GPU     | Adreno 650
Memory  | 8 / 12GB
Shipped Android Version | 10
Storage | 128 / 256GB
Battery | 5000 mAh
Dimensions | 161.1 x 71.4 x 9.6 mm
Display | 1080 x 2340 pixels, 6.7" OLED
Rear Camera  | 108 MP (f/1.8) + 8 MP (f/2.2) + 16MP (f/2.2)
Front Camera | 25 MP (f/2.0)

![Device Picture](https://fdn2.gsmarena.com/vv/pics/motorola/motorola-edge-plus-r3.jpg)

### Kernel Source

Check here: https://github.com/ixmoe/android_kernel_motorola_sm8250

### How to compile

```sh
. build/envsetup.sh
export LC_ALL=C
lunch omni_nio-eng
make -j4 recoveryimage
```

### Copyright
 ```
  /*
  *  Copyright (C) 2013-21 The OmniROM Project
  *
  * This program is free software: you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation, either version 3 of the License, or
  * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  *
  */
  ```
