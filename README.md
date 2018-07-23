# xspartan-xc3s50an

## Environment setup

0. Prerequisite

```
sudo apt install libusb-dev libftdi-dev
```

1. Installing the **xc3sprog**

```
git clone https://github.com/xtrx-sdr/xc3sprog.git

cd xc3sprog

mkdir build

cd build

cmake ..

make
```

2. Installing the **Vivado Design Suite**

* 1. Download the installer from [here](https://www.xilinx.com/support/download.html)

* 2. Type the following commands to start the installer:

```
chmod +x ./Xilinx_Vivado_SDK_Web_2018.2_0614_1954_Lin64.bin

sudo ./Xilinx_Vivado_SDK_Web_2018.2_0614_1954_Lin64.bin
```

* 3. Choose **Vivado HL System Edition**

* 4. After finished installing, type the following commands to install the Xilinx device driver:

```
cd /opt/Xilinx/Vivado/2018.2/data/xicom/cable_drivers/lin64/install_script/install_drivers

sudo ./install_drivers

sudo udevadm control --reload-rules
```
**If** the status indicator doesn't light up after step **iv**, and **lsusb** shows that your device ID is **03fd:000d**, try the following solution.

First, download the device firmware:

```
wget http://www.xilinx.com/txpatches/pub/utilities/fpga/xusbdfwu-1025.zip

unzip xusbdfwu-1025.zip

sudo cp xusbdfwu.hex /usr/share/xusbdfwu_fx2lp.hex
```

Then, replace the content of **/etc/udev/rules.d/52-xilinx-pcusb.rules** to:

```
ATTRS{idVendor}=="03fd", ATTRS{idProduct}=="0008", MODE="666"
SUBSYSTEMS=="usb", ACTION=="add", ATTRS{idVendor}=="03fd", ATTRS{idProduct}=="000d", MODE="666" ,RUN+="/sbin/fxload -v -t fx2lp -I /usr/share/xusbdfwu_fx2lp.hex -D $tempnode"
```

*Finally*, type the command:

```
sudo udevadm control --reload-rules
```

Some of the **Xilinx Platform Cable USB** from China was made of **fx2lp** microcontroller instead of **fx2**, so the solution presented above is to load the correct firmware.

Now, the device ID from **lsusb** should turn into **03fd:0008**
