# frozen_string_literal: true

class WebhooksController < Telegram::Bot::UpdatesController
  def add!(*links)
    result = MatchCreator.new.create_match(links)
    respond_with :message, text: result.message
  end

  def clean!
    respond_with :message, text: 'Данные удалены' if DB.clean
  end

  def predict!(*predictions)
    return respond_with :message, text: 'Матчи не добавлены' if DB.read[:matches].empty?
    return respond_with :message, text: 'Прогнозы не принимаются. Матчи стартовали' if DB.matches_started?

    result = PredictRecorder.new.save_predictions(from['id'], predictions)
    respond_with :message, text: result.message
  end

  def table!
    return respond_with :message, text: 'Матчи не добавлены' if DB.read[:matches].empty?

    result = TablePresenter.new.calculate_points
    respond_with :message, text: result.message
  end
end
