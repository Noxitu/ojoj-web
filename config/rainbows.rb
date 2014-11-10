worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
timeout 30
preload_app true

Rainbows! do
  use :EventMachine
end

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Rainbows master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Rainbows worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end
