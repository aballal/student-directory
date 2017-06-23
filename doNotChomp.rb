# We've been using the chomp() method to get rid of the last return character.
# Find another method among those provided by the String class that could be used for the same purpose
# (although it will require passing some arguments).

#Solving Step 8, Exercise 10 as a standalone problem since I do not wish to replace the elegant chomp in the project

print "Enter a name: "
name = gets
chomped_name = name.chomp
deleted_new_line_name = name.delete "\n"
puts "Input"
p name
puts "Chomped"
p chomped_name
puts "Deleted New Line"
p deleted_new_line_name
