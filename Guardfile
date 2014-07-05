require 'slack-notifier'
require 'dotenv'
Dotenv.load

ICECAST_LOG_FILE = ENV['PLAY_LOG']

def get_last_line file_path
  last_line = ''
  File.open(file_path) do |file|
    lines = file.read
    lines.each_line do |line|
      last_line = line.force_encoding('UTF-8')
    end
  end
  last_line
end

def notify message
  notifier = Slack::Notifier.new ENV['SLACK_TEAM'], ENV['SLACK_TOKEN'], channel: ENV['SLACK_CHANNEL']
  notifier.ping message
end

guard :shell do
  watch(%r{playlist.log}) {
    message = (get_last_line ICECAST_LOG_FILE)
    notify message
  }
end

