class MatchCreator
  def extract_links(links)
    result = Result.new

    if links.empty?
      result.message = 'Ссылки отстутсвуют'
      return result
    end

    messages_array = ['Добавлены матчи:']

    links.each do |link|
      parser_result = MatchParser.new.check_score(link)

      data = DB.read
      data[:matches].push(
        {
          home_team: parser_result.home_team,
          guest_team: parser_result.guest_team,
          result: parser_result.result,
          status: parser_result.status
        }
      )
      DB.write(data)
      messages_array.push("#{parser_result.home_team} - #{parser_result.guest_team}")
    end

    result.message = messages_array.join("\n")
    result
  end

  class Result
    attr_accessor :message
  end
end
