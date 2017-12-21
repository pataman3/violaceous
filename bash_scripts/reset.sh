#!/bin/bash
# completely wipes any changes
# resets the repo to the newest version
git reset --hard origin
git clean -f -d
git pull
