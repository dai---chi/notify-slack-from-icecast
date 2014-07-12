require 'sinatra'
require 'dotenv'
require 'pry'
Dotenv.load

set :environment, :production
enable :logging

get '/' do
  erb :index, locals: { playlist: ENV['PLAYLIST_FILE'] }
end

post '/skip' do
  %x(killall -USR1 ices)
end

get '/upload' do
  <<-HTML
  <html>
  <head><title>Multi file upload</title></head>
  <body>
    <form action="/upload" method="post" enctype="multipart/form-data">
      <input type="file" name="images[]" multiple />
      <input type="submit" />
    </form>
  </body>
  </html>
  HTML
end

post '/upload' do
  content_type :text

  res = "I received the following files:\n"
  res << params['images'].map{ |f| f[:filename] }.join("\n")

  params['images'].map { |uploaded_file|
    File.open("./music/#{uploaded_file[:filename]}", 'wb') { |f|
      f.write(uploaded_file[:tempfile].read)
    }
  }

  res
end
