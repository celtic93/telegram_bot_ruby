# frozen_string_literal: true

module BotPoller
  module_function

  def start!
    bot = Telegram::Bot::Client.new(ENV['TELEGRAM_TOKEN'])
    logger = Logger.new($stdout)
    poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger:)
    poller.start
  end
end
