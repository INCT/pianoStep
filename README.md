pianoStep
=========

ふつうの階段をピアノにしてみたんですよ


###つくりかた

####動作環境
- Arduino (1.0.5)
- RaspberryPi b+ (Raspbian September2014)
- 距離センサ [シャープ測距モジュール GP2Y0A02YK](http://akizukidenshi.com/catalog/g/gI-03158/)（20〜150cm）
- テープLED [Adafruit NeoPixel Digital RGB LED Strip](http://www.adafruit.com/product/1461)（1m x 4）

####回路
- 12個（段数分）の距離センサをArduinoのA2〜A13に配線
- 電源と出力安定のため5v-GND間とAin-GND間にそれぞれバイパスコンデンサをつける
- テープLEDの電源を供給する（長さと明るさによって必要な電流量が変化する、[詳細](https://learn.adafruit.com/adafruit-neopixel-uberguide/power)）

####Arduino
- Arduinoのインストール
- `git clone git@github.com:farundorL/pianoStep.git`
- Arduino(Mega)を接続して pianoStep/arduino/pianoStep/pianoStep.ino を書き込む
- Arduinoに距離センサとテープLEDを繋ぐ
- RaspberryPiに刺す

####Raspberry Pi
- `sudo apt-get install ruby-dev`
- `git clone git@github.com:farundorL/pianoStep.git`
- `cd pianoStep/raspberry`
- `bundle install`
- スピーカーを繋ぐ
- `ruby steppiano.rb /dev/ttyACM0` でArduinoのシリアルポートを引数として実行する
