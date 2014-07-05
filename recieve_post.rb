require 'sinatra'
require 'dotenv'
Dotenv.load

set :environment, :production
enable  :logging

get '/' do
  erb :index, locals: {playlist: ENV['PLAYLIST_FILE']}
end

post '/skip' do
  %x(killall -USR1 ices)
end

