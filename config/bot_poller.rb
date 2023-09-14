# frozen_string_literal: true

module BotPoller
  module_function

  def start!
    logger = Logger.new(ENV['RACK_ENV'] == 'development' ? $stdout : 'log/application.log')
    poller = Telegram::Bot::UpdatesPoller.new(Telegram.bot, WebhooksController, logger:)
    poller.start
  end
end
