# frozen_string_literal: true

require_relative '../../config/environment'

desc 'Gets results from website'
namespace :match_parser do
  task :live do
    Telegram.bot.send_message(chat_id: ENV['TELEGRAM_CHAT_ID'], text: 'Text')
  end
end
