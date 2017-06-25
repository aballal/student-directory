puts "Hello, I am #{__FILE__}"
puts "I live in #{File.dirname(__FILE__)}"
puts "You can call me #{File.basename(__FILE__)} for short"
puts ""

puts "I am going to read myself now!"
File.open(__FILE__,"r") do |file|
  file.readlines.each do |line|
    puts line
  end
end

puts "Wasn't that a neat trick?!"
