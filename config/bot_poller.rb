# frozen_string_literal: true

module BotPoller
  module_function

  def start!
    logger = Logger.new($stdout)
    poller = Telegram::Bot::UpdatesPoller.new(Telegram.bot, WebhooksController, logger:)
    poller.start
  end
end
