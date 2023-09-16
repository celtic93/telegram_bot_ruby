# frozen_string_literal: true

class PredictsPresenter
  def show_matches
    result = Result.new
    messages_array = []

    data = DB.read

    data[:matches].each_with_index do |match, index|
      match_array = []
      match_array.push("#{match[:home_team]} - #{match[:guest_team]} #{match[:result]} #{match[:status]}")
      predictions_array = data[:predictions].values.map { |pred| "#{pred[:name]} #{pred[:results][index]}" }
      match_array.push(predictions_array.join(' | '))
      messages_array.push(match_array.join("\n"))
    end

    result.message = messages_array.join("\n\n")
    result
  end

  class Result
    attr_accessor :message
  end
end
