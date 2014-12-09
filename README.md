iOS Piano
========

This is a simple piano application for ios.

It is an 88 key piano, 52 white and 36 black, but could be easily modified to hold a dynamic number of keys.

Currently the piano view loads inside of a UIScrollview thats content offset is controlled by a UISlider. When a piano key is played, a delegate method is called that provides the key number. From here you could play a sound or perform some custom actions. Right now it just logs the key number and frequency. 


![iOS Piano](http://www.sammeechward.com/images/Piano.png)
