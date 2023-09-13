class MatchCreator
  def extract_links(match_array)
    result = Result.new

    if match_array.empty?
      result.message = 'Ссылки отстутсвуют'
      return result
    end

    messages_array = ['Добавлены матчи:']

    match_array.each do |match|
      date_time, link_path = match.split('_')
      date_time = DateTime.parse("#{date_time} #{Time.zone}")
      parser_result = MatchParser.new.create_match(link_path)

      data = DB.read
      data[:matches].push(
        {
          home_team: parser_result.home_team,
          guest_team: parser_result.guest_team,
          result: parser_result.result,
          status: parser_result.status,
          date_time:,
          link_path:
        }
      )
      DB.write(data)
      messages_array.push(
        "#{date_time.strftime('%d-%m-%Y %H:%M')} #{parser_result.home_team} - #{parser_result.guest_team}"
      )
    end

    result.message = messages_array.join("\n")
    result
  end

  class Result
    attr_accessor :message
  end
end
