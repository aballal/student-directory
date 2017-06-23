#Add a message for each new print option
CUSTOM_MESSAGE = {
  :print_all => nil,
  :firstname_first_char => " filtered by first name's first letter",
  :name_less_than_12 => " filtered by names lesser than length 12"
}

LINE_WIDTH = 100

COHORT_LIST = [:january,:february,:march,:april,:may,:june,:july,:august,:september,:october,:november,:december]

def print_header(options=nil)
  options ||= :print_all
  puts ""
  puts "Students of Villains Academy".center(LINE_WIDTH)
  puts "(#{CUSTOM_MESSAGE[options]} )".center(LINE_WIDTH) unless CUSTOM_MESSAGE[options].to_s.empty?
  puts "#{'-'*LINE_WIDTH}"
end

def print_body(students)
  students.each_with_index do |student,index|
    print "#{index+1}.".rjust(5/100.0*LINE_WIDTH)
    print "#{student[:name]}".ljust(25/100.0*LINE_WIDTH)
    print "#{student[:cohort]} cohort".ljust(20/100.0*LINE_WIDTH)
    print "aged #{student[:age]}".ljust(10/100.0*LINE_WIDTH) unless student[:age].to_s.empty?
    print "from #{student[:country]}".ljust(20/100.0*LINE_WIDTH) unless student[:country].empty?
    print "loves #{student[:hobby]}".ljust(20/100.0*LINE_WIDTH) unless student[:hobby].empty?
    print "\n"
  end
end

def print_footer(count,options=nil)
  options ||= :print_all
  puts ""
  puts "Overall, we have #{count} great student#{count == 1 ? "" : "s"}#{CUSTOM_MESSAGE[options]}"
end

#Add a case when for each new print option
def print_students(students,options=nil)
  options ||= :print_all

  case options
  when :print_all
    students = students.sort_by {|student| COHORT_LIST.index(student[:cohort])}
  when :firstname_first_char
    students = select_firstname_first_char(students)
  when :name_less_than_12
    students = select_names_less_than_12(students)
  else
    puts "Invalid print option."
  end

  if students.empty?
      puts "Sorry, no#{options == :print_all ? "" : " such"} students"
  else
    print_header(options)
    print_body(students)
    print_footer(students.count,options)
  end
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
    while true
      print "Cohort: "
      cohort = gets.chomp.downcase.to_sym
      cohort = :november if cohort.empty?
      break if COHORT_LIST.include?(cohort)
      puts "Invalid cohort. Enter a month in full."
    end
    print "Hobby: "
    hobby = gets.chomp
    print "Age: "
    age = gets.chomp
    print "Country: "
    country = gets.chomp
    students << {name: name, cohort: cohort, hobby: hobby, age: age, country: country}
    puts "Now we have #{students.length} student#{students.length == 1 ? "" : "s"}"
    name = gets.chomp
  end
  students
end

=begin
#Using harcoded values for unit testing to save inputting time
students = [
  {name: "Dr. Ella Turner", cohort: :november, hobby: "Hiking", age: 35,country: "England"},
  {name: "Amelia Walsh", cohort: :november, hobby: "Sewing", age: 23,country: "Wales"},
  {name: "Mrs. Lisa Davidson", cohort: :may, hobby: "Knitting", age: 60,country: "England"},
  {name: "Edward Turner", cohort: :july, hobby: "Photography", age: 40,country: "England"},
  {name: "Karen Davidson", cohort: :january, hobby: "Scuba Diving", age: 30,country: "England"},
  {name: "Mr. Jan Hamilton", cohort: :december, hobby: "Camping", age: 45,country: "Scotland"},
  {name: "Deirdre Oliver", cohort: :july, hobby: "Drawing", age: 22,country: "Ireland"},
  {name: "Vanessa Sanderson", cohort: :november, hobby: "Dancing", age: 18,country: "USA"},
  {name: "Ms. Diane Newman", cohort: :april, hobby: "Stamp Collecting", age: 25,country: "France"},
  {name: "Mrs. Sue Mackenzie", cohort: :february, hobby: "Origami", age: 70,country: "England"},
  {name: "Mr. Gordon Morrison", cohort: :march, hobby: "Cooking", age: 51,country: "England"},
  {name: "Max Martin", cohort: :november, hobby: "Writing", age: 33,country: "Scotland"}
]
=end

students = input_students

while true
  print_option = print_menu
  break if print_option == :exit
  print_students(students,print_option)
end
