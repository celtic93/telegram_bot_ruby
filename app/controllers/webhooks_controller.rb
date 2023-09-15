# frozen_string_literal: true

class WebhooksController < Telegram::Bot::UpdatesController
  def add!(*links)
    return nil unless chat['id'] == ENV['TELEGRAM_CHAT_ID'].to_i
    return respond_with :message, text: 'Команда только для админа' unless from['id'] == ENV['ADMIN_ID'].to_i

    result = MatchCreator.new.create_match(links)
    respond_with :message, text: result.message
  end

  def clean!
    return nil unless chat['id'] == ENV['TELEGRAM_CHAT_ID'].to_i
    return respond_with :message, text: 'Команда только для админа' unless from['id'] == ENV['ADMIN_ID'].to_i

    respond_with :message, text: 'Данные удалены' if DB.clean
  end

  def predict!(*predictions)
    return nil unless chat['id'] == ENV['TELEGRAM_CHAT_ID'].to_i
    return respond_with :message, text: 'Матчи не добавлены' if DB.matches_empty?
    return respond_with :message, text: 'Прогнозы не принимаются. Матчи стартовали' if DB.matches_started?

    result = PredictRecorder.new.save_predictions(from['id'], predictions)
    respond_with :message, text: result.message
  end

  def predicts!
    return nil unless chat['id'] == ENV['TELEGRAM_CHAT_ID'].to_i
    return respond_with :message, text: 'Матчи не добавлены' if DB.matches_empty?

    result = PredictsPresenter.new.show_matches
    respond_with :message, text: result.message
  end

  def table!
    return nil unless chat['id'] == ENV['TELEGRAM_CHAT_ID'].to_i
    return respond_with :message, text: 'Матчи не добавлены' if DB.matches_empty?

    result = TablePresenter.new.calculate_points
    respond_with :message, text: result.message
  end
end
