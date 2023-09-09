# frozen_string_literal: true

set :output, 'log/application.log'

every 1.minute do
  rake 'hello'
end
