# frozen_string_literal: true

class WebhooksController < Telegram::Bot::UpdatesController
  def add!(*links)
    result = MatchCreator.new.extract_links(links)
    respond_with :message, text: result.message
  end
end
