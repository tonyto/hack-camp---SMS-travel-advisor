load 'service/polling.rb'

polling = Polling.new

while true
  polling.process()
  sleep(45)
end