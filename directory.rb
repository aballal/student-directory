CUSTOM_MESSAGE = {
  :print_all => nil,
  :firstname_first_char => " with your chosen alphabet"
}

#Unit tested print_header; working.
def print_header(options=nil)
  options ||= :print_all
  puts "The students of Villains Academy#{CUSTOM_MESSAGE[options]}"
  puts "----------------"
end

#Unit tested print body; working.
def print_body(students)
  students.each_with_index do |student,index|
    puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)"
  end
end

#Unit tested print_footer; working
def print_footer(count,options=nil)
  options ||= :print_all
  puts "Overall, we have #{count} great students#{CUSTOM_MESSAGE[options]}"
end

def print_students(students,options=nil)
  options ||= :print_all

  case options
  when :print_all
    print_header(options)
    print_body(students)
    print_footer(students.count,options)
  when :firstname_first_char
    print_header(options)
    students = select_firstname_first_char(students)
    print_body(students)
    print_footer(students.count,options)
  else
    puts "Invalid print option."
  end
end

#Unit tested print_menu; working.
def print_menu
  options = [nil,:print_all,:firstname_first_char]
  puts "Print Options"
  puts "-------------"
  puts "1. All Students"
  puts "2. Filtered by First Alphabet of First Name"
  print "Enter your choice 1/2: "
  options[gets.chomp.to_i]
end

def select_firstname_first_char(students)
  #To be coded. For now returning all students.
  students
end

#Unchanged baseline code for input_students; not unit tested again
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit enter twice"

  students = []
  name = gets.chomp
  while !name.empty?
    students << {name: name, cohort: :november}
    puts "Now we have #{students.length} students"
    name = gets.chomp
  end
  students
end

#Using harcoded values until each new method has been unit tested to save inputting time
students = [
  {name: "Dr. Hannibal Lecter", cohort: :november},
  {name: "Darth Vader", cohort: :november},
  {name: "Nurse Ratched", cohort: :november},
  {name: "Michael Corleone", cohort: :november},
  {name: "Alex DeLarge", cohort: :november},
  {name: "The Wicked Witch of the West", cohort: :november},
  {name: "Terminator", cohort: :november},
  {name: "Freddy Krueger", cohort: :november},
  {name: "The Joker", cohort: :november},
  {name: "Joffrey Baratheon", cohort: :november},
  {name: "Norman Bates", cohort: :november}
]
#students = input_students

print_option = print_menu
print_students(students,print_option)
