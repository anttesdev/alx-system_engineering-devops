#!/usr/bin/env ruby

matches = ARGV[0].match(/from:(?<sender>\+*\w+)\].*to:(?<receiver>\+*\w+)\].*flags:(?<flags>.*?)\]/)
if matches
  sender = matches[:sender]
  receiver = matches[:receiver]
  flags = matches[:flags]
  puts "#{sender},#{receiver},#{flags}"
end
