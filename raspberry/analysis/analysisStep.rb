require 'time'

all_step = {}
first_time = ARGV.length == 1 ? Time.parse(ARGV[0]) : Time.now
last_time = first_time + 24 * 60 * 60

12.times.each do |i|
  all_step[i] = {}

  open("tmp/#{i}StepLog.txt").each do |line|
    path, num = line.split ':'
    yyyy, mm, dd, h, mi = path.split('/')[2, 5]

    time = Time.parse sprintf('%d-%d-%d_%d:%d', yyyy, mm, dd, h, mi)

    all_step[i][time] = num.to_i + 0
  end

  all_step[i].sort
end

step_log = {}
f = open('stepLog.csv', 'w')
while first_time < last_time
  step_log[first_time] = {}

  time = first_time.to_s.split(' +').first
  f.print(time)

  all_step.each do |key, value|
    limit_time = first_time + 10 * 60

    ranged_step = value.select { |t, _| first_time <= t && t < limit_time }
    step_num = ranged_step.map { |_, n| n }.inject { |a, e| a + e }.to_i
    step_log[first_time][key] = step_num

    f.print(", #{step_num}")
  end
  f.print("\n")

  first_time += 10 * 60
end

f.close
