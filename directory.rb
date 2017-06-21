#Add a message for each new print option
CUSTOM_MESSAGE = {
  :print_all => nil,
  :firstname_first_char => " filtered by first name's first letter",
  :name_less_than_12 => " filtered by names lesser than length 12"
}

def print_header(options=nil)
  options ||= :print_all
  puts ""
  puts "The students of Villains Academy#{CUSTOM_MESSAGE[options]}"
  puts "----------------"
end

def print_body(students)
  index = 0
  while index < students.length
  #students.each_with_index do |student,index|
    student = students[index]
    puts "#{index+1}. #{student[:name]} (#{student[:cohort]} cohort)"
    index += 1
  end
end

def print_footer(count,options=nil)
  options ||= :print_all
  puts "Overall, we have #{count} great students#{CUSTOM_MESSAGE[options]}"
  puts ""
end

#Add a case when for each new print option
def print_students(students,options=nil)
  options ||= :print_all

  case options
  when :print_all
    #Nothing to do
  when :firstname_first_char
    students = select_firstname_first_char(students)
  when :name_less_than_12
    students = select_names_less_than_12(students)
  else
    puts "Invalid print option."
  end
  print_header(options)
  print_body(students)
  print_footer(students.count,options)
end

#Add an array element and puts statement, update valid input range, for each new print option
def print_menu
  options = [nil,:print_all,:firstname_first_char,:name_less_than_12,:exit]
  puts ""
  puts "Print Options"
  puts "-------------"
  puts "1. All Students"
  puts "2. Filtered by First Name's First Letter"
  puts "3. Filtered by Names Lesser than Length 12"
  puts "4. Exit"
  print "Enter your choice [1-4]: "
  options[gets.chomp.to_i]
end

def select_firstname_first_char(students)
  titles = ["Mr", "Mrs", "Ms", "Dr"]
  selected_students = []

  print "Enter the alphabet [A-Z|a-z]: "
  first_char = gets.chomp.upcase

  students.each do |student|
    split_name = student[:name].split(/[ \.]/).reject {|word| word == ""}
    first_name = titles.include?(split_name[0]) ? split_name[1] : split_name[0]
    if first_name[0].upcase == first_char
      selected_students << student
    end
  end
  selected_students
end

def select_names_less_than_12(students)
  #Length ignoring ' ' and '.'
  selected_students = []
  students.each do |student|
    split_name = student[:name].split(/[ \.]/).reject {|word| word == ""}
    if split_name.join.length < 12
      selected_students << student
    end
  end
  selected_students
end

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

=begin
#Using harcoded values for unit testing to save inputting time
students = [
  {name: "Dr. Ella Turner", cohort: :november},
  {name: "Amelia Walsh", cohort: :november},
  {name: "Mrs. Lisa Davidson", cohort: :november},
  {name: "Edward Turner", cohort: :november},
  {name: "Karen Davidson", cohort: :november},
  {name: "Mr. Jan Hamilton", cohort: :november},
  {name: "Deirdre Oliver", cohort: :november},
  {name: "Vanessa Sanderson", cohort: :november},
  {name: "Ms. Diane Newman", cohort: :november},
  {name: "Mrs. Sue Mackenzie", cohort: :november},
  {name: "Mr. Gordon Morrison", cohort: :november},
  {name: "Max Martin", cohort: :november}
]
=end

students = input_students

while true
  print_option = print_menu
  break if print_option == :exit
  print_students(students,print_option)
end
