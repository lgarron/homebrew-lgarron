#!/bin/bash

# From a script by Leland Batey: https://gist.github.com/lelandbatey/8677901
convert "$1" -morphology Convolve DoG:15,100,0 -negate -normalize -blur 0x1 -channel RBG -level 60%,91%,0.1 "$1.png"