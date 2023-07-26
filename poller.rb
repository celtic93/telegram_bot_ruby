# frozen_string_literal: true

require 'logger'
require 'telegram/bot'
require_relative 'webhooks_controller'

bot = Telegram::Bot::Client.new(ENV['TELEGRAM_TOKEN'])
logger = Logger.new($stdout)
poller = Telegram::Bot::UpdatesPoller.new(bot, WebhooksController, logger:)
poller.start
