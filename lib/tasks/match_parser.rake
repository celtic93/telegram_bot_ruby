# frozen_string_literal: true

require_relative '../../config/environment'

desc 'Gets results from website'
namespace :match_parser do
  task :live do
    bot = Telegram::Bot::Client.new(ENV['TELEGRAM_TOKEN'])
    bot.send_message(chat_id: '-960187715', text: 'Text')
  end
end
