#!/bin/sh
set -e
mkdir -p $1
cp -rv /home/sysmanj/Documents/code/.template/* $1/
cp -rv /home/sysmanj/Documents/code/.template/.[^.]* $1/
cd $1
rm -rf .git
touch .projectile
git init
git add -A
git commit -m 'init'
