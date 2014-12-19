#!/usr/bin/env ruby
# coding: utf-8

require 'optparse'

SHORT_UNIT_MINUTE = 15  # ショートは15分単位
SHORT_UNIT_FEE = 206    # 1ショート単位あたりの料金

# パック料金（ナイトパック未対応）
HOUR_PACK_FEE = {
  6 => 4020,
  12 => 6690,
  24 => 8230
}

# 1kmあたりの料金
DISTANCE_RATES = Hash.new(16)
DISTANCE_RATES[6] = 0

def hour_minute_to_minute(t)
  a = t.split(':')
  a[0].to_i * 60 + a[1].to_i
end

def parse_time(t)
  case t
  when /[0-9]+:[0-9]/
    minute = hour_minute_to_minute(t)
  when /[0-9]+/
    minute = t.to_i
  else
    nil
  end
end

# k: 利用予定 km
# t: 借りる時間
params = ARGV.getopts('k:t:')

minute = parse_time(params['t'])
unless minute
  $stderr.puts '利用時間が正しくありません'
  $stderr.puts '"時:分"または"分"を指定してください'
  exit 1
end

unless params['k'].respond_to?(:to_i)
  $stderr.puts '走行距離は整数で指定してください'
  exit 1
end
km = params['k'].to_i

puts "走行距離: #{km}, 借りる時間: #{minute}分"
