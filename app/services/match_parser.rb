class MatchParser
  def check_score(link)
    uri = "#{ENV['LIVE_SCORES_WEBSITE']}#{link}"
    page = Nokogiri::HTML(URI.parse(uri).open)

    home_team = page.css('#team > a')[0].text
    guest_team = page.css('#team > a')[1].text
    result = page.css('#result')[0]&.text
    status = page.css('#status')[0]&.text

    Result.new(home_team, guest_team, result, status)
  end

  class Result
    attr_reader :home_team, :guest_team, :result, :status

    def initialize(home_team, guest_team, result, status)
      @home_team = home_team
      @guest_team = guest_team
      @result = result
      @status = status
    end
  end
end
