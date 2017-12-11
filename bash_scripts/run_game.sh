#!/bin/bash
# pulls and runs the game. this code is used to create a shortcut
# to the game that runs the latest version. Kyle uses a modified
# version of the code (different file path to project folder) in
# his shortcut.
export PATH=/usr/local/bin:$PATH # may not work in windows/linux
cd ~/programming/godot/violaceous # unique to peter's mac
git pull https://github.com/pataman3/violaceous.git
cd game
godot
