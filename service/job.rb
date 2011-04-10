load 'service/polling.rb'

polling = Polling.new
last_checked = Time.new(-1)

while true
  polling.process(last_checked)
  last_checked = Time.now
  sleep(45)
end