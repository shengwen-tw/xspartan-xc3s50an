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
