#!/bin/sh
set -e
mkdir -p $1
cp -rv /home/hypen9/Documents/code/C/.c-skeleton/* $1/
cp -rv /home/hypen9/Documents/code/C/.c-skeleton/.[^.]* $1/
cd $1
rm -rf .git
touch .projectile
git init
git add -A
git commit -m 'init'
