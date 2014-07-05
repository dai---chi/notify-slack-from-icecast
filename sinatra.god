require 'god'
require 'dotenv'
Dotenv.load

God.pid_file_directory = File.dirname(__FILE__)+'/tmp/god_pids'
God.port = ENV['PORT'][1]
God.watch do |w|
  w.name = 'sinatra'
  w.start = 'ruby recieve_post.rb'
  w.dir = File.dirname(__FILE__)
  w.log = File.dirname(__FILE__)+'/log/sinatra.log'
  w.keepalive
end
