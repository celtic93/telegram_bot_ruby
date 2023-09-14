# frozen_string_literal: true

class PredictRecorder
  def save_predictions(id, predictions)
    result = Result.new

    predictions.each do |prediction|
      index, match_result = prediction.split('.')
      corrected_index = index.to_i - 1
      DB.create_prediction(id, corrected_index, match_result)
    end

    data = DB.read

    if predictions.any?
      messages_array = ["Текущие прогнозы игрока #{data[:predictions][id.to_s.to_sym][:name]}"]
      data[:matches].each_with_index do |match, i|
        messages_array.push(
          "#{i + 1}. #{match[:home_team]} - #{match[:guest_team]} #{data[:predictions][id.to_s.to_sym][:results][i]}"
        )
      end

      result.message = messages_array.join("\n")
    else
      result.message = 'Предикты пусты'
    end

    result
  end

  class Result
    attr_accessor :message
  end
end
