#!/usr/bin/env ruby
#
#
require 'net/smtp'

SERVER=ARGV[0]
USER=ARGV[1]
PASSWD=ARGV[2]
MAIL_TO=ARGV[3]


puts "Server #{SERVER}"

s = Net::SMTP.new(SERVER)
s.enable_starttls_auto
s.start do |smtp|
  if smtp.capable_starttls?
    puts "Does TLS"
  end


  puts "Auth types: #{smtp.capable_auth_types}"
  if smtp.capable_cram_md5_auth?
    puts "LOGIN CRAM MD5"
    smtp.auth_cram_md5(USER,PASSWD)
  elsif smtp.capable_login_auth?
    puts "LOGIN AUTH"
    smtp.auth_login(USER,PASSWD)
  else
    puts "not LOGIN AUTH"
  end


  puts smtp.inspect
end
