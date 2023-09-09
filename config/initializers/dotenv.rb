# frozen_string_literal: true

Dotenv.load if ENV['RACK_ENV'] == 'development'
