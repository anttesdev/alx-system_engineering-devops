#!/usr/bin/env ruby
puts ARGV[0].scan(/from:\+*\w*/).join[5..-1] + "," + 
     ARGV[0].scan(/to:\+*\w*/).join[3..-1] + "," + 
     ARGV[0].scan(/flags:(.*?)\]/).join
