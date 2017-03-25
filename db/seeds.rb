(1..20).each do |number|
  Task.create(content: 'test task' + number.to_s, status: '検討中')
end