# frozen_string_literal: true

require 'json'

module DB
  module_function

  DATA_FILE_PATH = "#{File.expand_path('..', __dir__)}/db/data.json".freeze
  SCHEMA_FILE_PATH = "#{File.expand_path('..', __dir__)}/db/schema.json".freeze

  def read
    JSON.parse(File.read(DATA_FILE_PATH)).deep_symbolize_keys
  end

  def write(data)
    File.write(DATA_FILE_PATH, data.to_json)
    true
  end

  def update_match(link_path, params)
    data = read
    data[:matches].detect { |d| d[:link_path] == link_path }.update(params)
    write(data)
    true
  end

  def create_prediction(id, index, result)
    data = read
    data[:predictions][id.to_s.to_sym][:results][index] = result
    write(data)
    true
  end

  def matches_started?
    matches = read[:matches]
    matches.map { |match| DateTime.parse(match[:date_time]) }.any? { |date_time| Time.zone.now > date_time }
  end

  def matches_empty?
    read[:matches].empty?
  end

  def clean
    schema = JSON.parse(File.read(SCHEMA_FILE_PATH)).deep_symbolize_keys
    JSON.parse(ENV['PLAYERS_INFO_ARRAY']).each do |player|
      schema[:predictions][player['id']] = { name: player['name'], results: [] }
    end

    File.write(DATA_FILE_PATH, schema.to_json)
    true
  end
end
