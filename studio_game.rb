name1 = 'larry'
health1 = 60
puts "#{name1.capitalize}'s health is #{health1}"

name2 = 'curly'
health2 = 125
puts "#{name2.upcase} has a health of #{health2}"

health2 = health1
puts "#{name2.upcase} has a health of #{health2}"

health1 = 30
puts "#{name1.capitalize}'s health is #{health1}"
puts "#{name2.upcase} has a health of #{health2}"

name3 = 'moe'
health3 = 100
puts "#{name3.capitalize} has a health of #{health3}.".center(50, '*')

name4 = 'shemp'
health4 = 90
puts "#{name4.capitalize.ljust(30, '.')} #{health4} health"

current_time = Time.new
puts current_time.strftime("The game started on %A %m/%d/%Y at%l:%M%p")




# puts "Players:\n\t#{name1}\n\t#{name2}\n\t#{name3}"