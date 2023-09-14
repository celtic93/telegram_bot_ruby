# frozen_string_literal: true

class WebhooksController < Telegram::Bot::UpdatesController
  def add!(*links)
    result = MatchCreator.new.create_match(links)
    respond_with :message, text: result.message
  end

  def clean!
    respond_with :message, text: 'Данные удалены' if DB.clean
  end
end
