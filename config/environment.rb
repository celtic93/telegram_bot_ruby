# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

require_relative 'application_loader'
ApplicationLoader.load_app!

require_relative 'bot_poller'
BotPoller.start!