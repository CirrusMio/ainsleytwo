ainsleytwo
==========

![](http://i.imgur.com/3uwBUxl.jpg)

## Running Server

Deamonized Thin

`sudo thin -a 10.0.1.101 -p 80 -R config.ru -d --pid thin.pid start`

## Getting Started

On Raspberry Pi, install the fake say command. A say command is already installed on OS X.

`cp lib/say /usr/bin/say`

`chmod +x /usr/bin/say`

Say Command inspired from:
http://www.jacobsalmela.com/raspberry-pi-and-the-say-command-from-osx-how-to-make-your-pi-speak-at-will/

## Have Ainsley II make announcements

curl --data "words=you+look+marvelous&token=abc123" http://127.0.0.1:80/say

## Raspberry Pi setup

`sudo apt-get update`

Install git:

`sudo apt-get install git`

Install ruby:

`sudo apt-get install ruby` #=> ruby 1.9.3, ruby 2 would be better

`sudo apt-get install ruby-dev` #=> provides required libraries

Install bundler:

`sudo gem install bundler`

Clone Ainsley II:

`git clone https://github.com/CirrusMio/ainsleytwo.git`

Bundle gems:

`cd ~/ainsleytwo && sudo bundle install`

Install audio player(s):

`sudo apt-get install mplayer`

Configure Pi to send audio out of the 3.5mm jack:

`sudo amixer cset numid=3 1`
