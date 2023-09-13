class MatchMonitor
  MATCH_ENDED_STATUS = 'Match ended'.freeze

  def check_score(match)
    result = Result.new

    date_time_now = Time.zone.now
    match_date_time = DateTime.parse(match[:date_time])

    return result if date_time_now < match_date_time || match[:status] == MATCH_ENDED_STATUS

    messages_array = []
    parser_result = MatchParser.new.create_match(match[:link_path])
    DB.update_match(match[:link_path], result: parser_result.result, status: parser_result.status)

    if match[:status].nil? && parser_result.status.present? && parser_result.status != MATCH_ENDED_STATUS
      messages_array.push('Матч начался')
    end
    messages_array.push('Изменение в счете') if match[:result].present? && match[:result] != parser_result.result
    messages_array.push('Матч закончился') if parser_result.status == MATCH_ENDED_STATUS

    if messages_array.any?
      messages_array.push("#{parser_result.home_team} - #{parser_result.guest_team}")
      messages_array.push(parser_result.result)
      result.message = messages_array.join("\n")
    end

    result
  end

  class Result
    attr_accessor :message
  end
end
