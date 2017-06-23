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
  when :save
    save_students(students)
  when :load
    students = load_students(students)
  else
    puts "Invalid selection, try again."
  end
  students
end

def print_menu
  option = [nil,:input,:display_all,:save,:load,nil,nil,nil,nil,:exit]
  puts ""
  puts "Menu".center(LINE_WIDTH/4)
  puts "#{"-" * (LINE_WIDTH/4)}"
  puts "1. Input Students"
  puts "2. Display Students"
  puts "3. Save Students to File"
  puts "4. Load Students from File"
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
    print "Age: "
    age = gets.chomp
    print "Country: "
    country = gets.chomp
    print "Hobby: "
    hobby = gets.chomp
    students << {name: name, cohort: cohort, age: age, country: country, hobby: hobby}
    puts "Now we have #{students.length} student#{students.length == 1 ? "" : "s"}"
    name = gets.chomp
  end
  students
end

def save_students(students)
  file = File.open("students.csv","w")
  students.each { |student| file.puts [student[:name],student[:cohort],student[:age],student[:country],student[:hobby]].join(",")}
  file.close
end

def load_students(students)
  file = File.open("students.csv","r")
  file.readlines.each do |line|
    name, cohort, age, country, hobby = line.chomp.split(",")
    students << {name: name, cohort: cohort.to_sym, age: age, country: country, hobby: hobby}
  end
  file.close
  students
end

=begin
#Using harcoded values for unit testing to save inputting time
students = [
  {name: "Dr. Ella Turner", cohort: :november, age: 35,country: "England", hobby: "Hiking"},
  {name: "Amelia Walsh", cohort: :november, age: 23,country: "Wales", hobby: "Sewing"},
  {name: "Mrs. Lisa Davidson", cohort: :may, age: 60,country: "England", hobby: "Knitting"},
  {name: "Edward Turner", cohort: :july, age: 40,country: "England", hobby: "Photography"},
  {name: "Karen Davidson", cohort: :january, age: 30,country: "England", hobby: "Scuba Diving"},
  {name: "Mr. Jan Hamilton", cohort: :december, age: 45,country: "Scotland", hobby: "Camping"},
  {name: "Deirdre Oliver", cohort: :july, age: 22,country: "Ireland", hobby: "Drawing"},
  {name: "Vanessa Sanderson", cohort: :november, age: 18,country: "USA", hobby: "Dancing"},
  {name: "Ms. Diane Newman", cohort: :april, age: 25,country: "France", hobby: "Stamp Collecting"},
  {name: "Mrs. Sue Mackenzie", cohort: :february, age: 70,country: "England", hobby: "Origami"},
  {name: "Mr. Gordon Morrison", cohort: :march, age: 51,country: "England", hobby: "Cooking"},
  {name: "Max Martin", cohort: :november, age: 33,country: "Scotland", hobby: "Writing"}
]
=end

students = []
loop do
  option = print_menu
  break if option == :exit
  students = process_students(students,option) || []
end
