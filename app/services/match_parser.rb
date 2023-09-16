# frozen_string_literal: true

class MatchParser
  LIVE_SCORES_WEBSITE = 'https://www.livesoccertv.com/match/'

  def extract_link(link_path)
    uri = "#{LIVE_SCORES_WEBSITE}#{link_path}"
    page = Nokogiri::HTML(URI.parse(uri).open)

    home_team = page.css('#team > a')[0].text
    guest_team = page.css('#team > a')[1].text
    result = page.css('#result')[0]&.text
    status = page.css('#status')[0]&.text || (MatchMonitor::MATCH_ENDED_STATUS if page.css('#warning').any?)

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
