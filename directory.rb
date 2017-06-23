LINE_WIDTH = 100

COHORT_LIST = [:january,:february,:march,:april,:may,:june,:july,:august,:september,:october,:november,:december]

def print_header
  puts ""
  puts "Students of Villains Academy".center(LINE_WIDTH)
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

def print_footer(count)
  puts ""
  puts "Overall, we have #{count} great student#{count == 1 ? "" : "s"}"
end

def process_students(students,option)
  case option
  when :input
    students = input_students(students)
  when :display_all
    if students.empty?
        puts "Sorry, no students to display"
    else
      print_header
      print_body(students)
      print_footer(students.count)
    end
  else
    puts "Invalid selection, try again."
  end
  students
end

def print_menu
  option = [nil,:input,:display_all,nil,nil,nil,nil,nil,nil,:exit]
  puts ""
  puts "Menu".center(LINE_WIDTH/4)
  puts "#{"-" * (LINE_WIDTH/4)}"
  puts "1. Input Students"
  puts "2. Display Students"
  puts "9. Exit"
  print "Enter your choice [1-2,9]: "
  option[gets.chomp.to_i]
end

def input_students(students)
  puts "Please enter the names of the students"
  puts "To finish, just hit enter twice"

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

students = []
loop do
  option = print_menu
  break if option == :exit
  students = process_students(students,option)
end
