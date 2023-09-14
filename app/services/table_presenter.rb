# frozen_string_literal: true

class TablePresenter
  CORRECT_SCORE_POINTS = 4
  HANDICAP_POINTS = 2
  MATCH_RESULT_POINTS = 1

  def calculate_points
    result = Result.new
    messages_array = ['Турнирная таблица:']

    data = DB.read

    data[:predictions].each_value do |prediction|
      points = 0

      data[:matches].each_with_index do |match, index|
        next if match[:result].nil? || match[:status].nil? || prediction[:results][index].nil?

        match_score_array = match[:result].split(' - ').map(&:to_i)
        prediction_array = prediction[:results][index].split('-').map(&:to_i)

        match_handicap = match_score_array[0] - match_score_array[1]
        prediction_handicap = prediction_array[0] - prediction_array[1]

        if match_score_array == prediction_array
          points += CORRECT_SCORE_POINTS
        elsif match_handicap == prediction_handicap
          points += HANDICAP_POINTS
        elsif (match_handicap * prediction_handicap).positive?
          points += MATCH_RESULT_POINTS
        end
      end

      messages_array.push("#{prediction[:name]} #{points}")
    end

    result.message = messages_array.join("\n")
    result
  end

  class Result
    attr_accessor :message
  end
end
