require 'slack-notifier'
require 'dotenv'
Dotenv.load

ICECAST_LOG_FILE = '/var/log/icecast/playlist.log'

def get_last_line file_path
  last_line = ''
  File.open(file_path) do |file|
    lines = file.read
    lines.each_line do |line|
      last_line = line
    end
  end
  last_line
end

def notify message
  notifier = Slack::Notifier.new 'reborn', ENV['SLACK_TOKEN'], channel: '#dch_sandbox'
  notifier.ping message
end

guard :shell do
  watch(%r{playlist.log}) {
    message = (get_last_line ICECAST_LOG_FILE)
    notify message
  }
end

