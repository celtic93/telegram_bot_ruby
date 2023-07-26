# frozen_string_literal: true

class WebhooksController < Telegram::Bot::UpdatesController
  def start!(*)
    respond_with :message, text: 'Привет! Пиши!'
  end

  def message(message)
    respond_with :message, text: "Ты написал: #{message['text']}"
  end
end
