#!/bin/sh
set -e
mkdir $1
cp -rv /home/sysmanj/Documents/code/.template/* $1/
cd $1
touch .projectile
git init
git add -A
git commit -m 'init'
