# frozen_string_literal: true

require_relative '../../config/environment'

desc 'Gets results from website'
namespace :match_parser do
  task :live do
    matches = DB.read[:matches]
    matches.each do |match|
      result = MatchMonitor.new.check_score(match)
      Telegram.bot.send_message(chat_id: ENV['TELEGRAM_CHAT_ID'], text: result.message) if result.message.present?
    end
  end
end
