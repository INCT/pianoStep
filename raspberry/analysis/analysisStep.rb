require 'time'

allStep = {}
firstTime = Time.now; if(ARGV.length == 1) then firstTime = Time.parse(ARGV[0]) end
lastTime = firstTime + 24 * 60 * 60

12.times.each do |i|
  allStep[i] = {}

  open("tmp/#{i}StepLog.txt").each{ |line|
    path, num = line.split ':'
    yyyy,mm,dd,h,mi = path.split('/')[2,5]
puts path
    time = Time.parse sprintf("%d-%d-%d_%d:%d", yyyy, mm, dd, h, mi)

    allStep[i][time] = num.to_i + 0
  }

  allStep[i].sort
end

stepLog = {}
f = open('stepLog.csv', 'w')
while firstTime < lastTime do
  stepLog[firstTime] = {}

  time = firstTime.to_s.split(' +').first
  f.print(time)

  allStep.each{ |sKey, sValue|
    limitTime = firstTime + 10 * 60

    rangedStep = sValue.select{ |key,value| firstTime <= key && key < limitTime }
    stepNum = rangedStep.map{ |key, value| value }.inject{ |sum, value| sum + value }.to_i
    stepLog[firstTime][sKey] = stepNum

    f.print(", #{stepNum}")
  }
  f.puts('')

  firstTime += 10 * 60
end

f.close
