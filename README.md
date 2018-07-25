# xspartan-xc3s50an

Xilinx Spartan 3-AN FPGA sample programs and environment setup guide for beginners. 

## Getting started with sample programs

1. Initialize the project

```
make init
```

2. Synthesize

```
make synthesize
```

3. Implement design

```
make implement_design
```

4. Generate programming file (.bit stream)

```
make generate_programming_file
```

You could also type the following command to do 4 steps in 1:

```
make all
```

Then, use **ISE Impact** to program the FPGA:

```
make impact
```

## Environment setup

**Tested environment:**

* Ubuntu 16.04 (4.9.0-040900-generic)

* Xilinx ISE Design Suite 14.7

**Tested hardwares:**

* Customized XC3S50AN board (Xilinx Spartan 3-AN)

* Xilinx Platform Cable USB (JTAG)

0. Prerequisite

```
sudo apt install libusb-dev libftdi-dev
```

1. Installing the **Xilinx ISE Design Suite 14.7**

* 1. Download the installer from [here](https://www.xilinx.com/support/download.html)

* 2. Type the following commands to start the installer:

```
tar -xvf Xilinx_ISE_DS_Lin_14.7_1015_1.tar

cd Xilinx_ISE_DS_Lin_14.7_1015_1/

sudo ./xsetup
```

* 3. select **ISE WebPACK**

* 4. After the installation, type:

```
source /opt/Xilinx/14.7/ISE_DS/settings64.sh && ise
```

* 5. Register the product (get the key from Xilinx's website)

2. Installing **Xinlinx Platforn Cable USB** driver

* 1. Clone and compile the **usb-driver** program

```
cd /tmp

git clone git://git.zerfleddert.de/usb-driver

cd cd usb-driver/

make

sudo cp libusb-driver.so /usr/local/lib/libusb-driver.so
```

* 2. Paste the following instrunction under **.bashrc** and restart the terminal:

```
LD_PRELOAD=/usr/local/lib/libusb-driver.so
```

* 3. Copy the cable driver from ISE installed path to **/usr/share**:

```
cd /opt/Xilinx/14.7/ISE_DS/common/bin/lin64

sudo cp *.hex /usr/share/

```

* 4. Create **/etc/udev/rules.d/52-xilinx-pcusb.rules** with the content of:

```
ATTRS{idVendor}=="03fd", ATTRS{idProduct}=="0008", MODE="666"
SUBSYSTEMS=="usb", ACTION=="add", ATTRS{idVendor}=="03fd", ATTRS{idProduct}=="000d", MODE="666" ,RUN+="/sbin/fxload -v -t fx2lp -I /usr/share/xusb_emb.hex -D $tempnode"
```

**Finally**, type the command:

```
sudo udevadm control --reload-rules
```

## Reference

[[1]](https://isite.tw/2015/09/30/13717)
