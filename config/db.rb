# frozen_string_literal: true

require 'json'

module DB
  module_function

  DATA_FILE_PATH = "#{File.expand_path('..', __dir__)}/db/data.json".freeze
  SCHEMA_FILE_PATH = "#{File.expand_path('..', __dir__)}/db/schema.json".freeze

  def read
    JSON.parse(File.read(DATA_FILE_PATH)).symbolize_keys
  end

  def write(data)
    File.write(DATA_FILE_PATH, data.to_json)
    true
  end

  def clean
    schema = JSON.parse(File.read(SCHEMA_FILE_PATH))
    File.write(DATA_FILE_PATH, schema)
    true
  end
end
