require 'serialport'
require 'time'
require 'logger'

# 引数が１つでなければ終了
exit if(ARGV.length != 1)

# 再生する音楽ファイル一覧
sounds = [
 'piano/C3.wav', 'piano/D3.wav', 'piano/E3.wav', 'piano/F3.wav',
 'piano/G3.wav', 'piano/A3.wav', 'piano/B3.wav', 'piano/C4.wav',
 'piano/D4.wav', 'piano/E4.wav', 'piano/F4.wav', 'piano/G4.wav'
]

def play(n, wav)
  system "aplay #{wav} &"
  log(n)
  # puts "#{n} steped"
end

def log(n)
  puts 'logged'
  t = Time.now
  path = [t.year, t.month, t.day, t.hour, t.min].join("/")
  system "echo '#{n}' >> log/#{path}"
end

logger = Logger.new('log/error.log')

begin
  # シリアル通信を開始する、ボーレートは 19200
  serial = SerialPort.new(ARGV[0], 19200)
  puts 'connected'

  loop{
    # 一行読み込み、文字数をチェックする
    line = serial.readline.chomp
    next unless(line.length == 12)

    # i文字目が'1'ならば音楽ファイルを再生する
    line.length.times.each do |i|
      # &をつけることにより外部コマンドをバックグラウンドで実行する
      if(line[i] == "1") then
        play(i, sounds[i])
      end
      #play(i) if(line[i] == "1")

    end
  }
rescue => err
  logger.fatal err
  puts 'dead...'
  sleep(10)
  puts 'reborn!'
  retry
end
