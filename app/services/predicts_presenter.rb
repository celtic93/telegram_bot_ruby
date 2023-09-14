# frozen_string_literal: true

class PredictsPresenter
  def show_matches
    result = Result.new
    messages_array = []

    data = DB.read

    data[:matches].each_with_index do |match, index|
      messages_array.push("#{match[:home_team]} - #{match[:guest_team]} #{match[:result]} #{match[:status]}")
      data[:predictions].each_value do |prediction|
        messages_array.push("#{prediction[:name]} #{prediction[:results][index]}")
      end
    end

    result.message = messages_array.join("\n")
    result
  end

  class Result
    attr_accessor :message
  end
end
