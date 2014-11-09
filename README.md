pianoStep
=========

ふつうの階段をピアノにしてみたんですよ


###つくりかた

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
