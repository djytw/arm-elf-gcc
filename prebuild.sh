#!/bin/bash

sudo apt install libncurses5-dev libgmp-dev libmpfr-dev
sudo apt remove texinfo
rm -rf texinfo-4.13

tar -xf texinfo-4.13.tar.gz
cd texinfo-4.13
./configure
make all
sudo make install
