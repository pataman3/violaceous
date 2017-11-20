#!/bin/bash
export PATH=/usr/local/bin:$PATH
cd ~/programming/godot/violaceous
git pull https://github.com/pataman3/violaceous.git
cd game
godot
