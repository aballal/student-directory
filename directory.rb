LINE_WIDTH = 100

COHORT_LIST = [:january,:february,:march,:april,:may,:june,:july,:august,:september,:october,:november,:december]

DEFAULT_FILE = "students.csv"

def print_header
  puts ""
  puts "Students of Villains Academy".center(LINE_WIDTH)
  puts "#{'-'*LINE_WIDTH}"
end

def print_body(students)
  students.each_with_index do |student,index|
    print "#{index+1}.".rjust(5/100.0*LINE_WIDTH)
    print "#{student[:name]}".ljust(25/100.0*LINE_WIDTH)
    print "#{student[:cohort].capitalize} cohort".ljust(20/100.0*LINE_WIDTH)
    print "aged #{student[:age]}".ljust(10/100.0*LINE_WIDTH) unless student[:age] == 0
    print "from #{student[:country]}".ljust(20/100.0*LINE_WIDTH) unless student[:country].empty?
    print "loves #{student[:hobby]}".ljust(20/100.0*LINE_WIDTH) unless student[:hobby].empty?
    print "\n"
  end
end

def print_footer(count)
  puts ""
  puts "Overall, we have #{count} great student#{plural(count)}"
end

def display_students(students)
  if students.empty?
    puts "Sorry, no students to display"
  else
    print_header
    print_body(students)
    print_footer(students.count)
  end
end

def process_students(students,option)
  case option
  when :input
    students = input_students(students)
  when :display_all
    display_students(students)
  when :save
    save_students(students,get_filename)
  when :load
    students = load_students(students,get_filename)
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
  print "Enter your choice [1-4,9]: "
  option[STDIN.gets.chomp.to_i]
end

class String
  def init_caps
    self.split.map {|word| word.capitalize}.join(" ")
  end
end

def input_students(students)
  puts "Please enter the names of the students"
  puts "To finish, just hit enter twice"

  name = STDIN.gets.chomp.init_caps
  while !name.empty?
    while true
      print "Cohort: "
      cohort = STDIN.gets.chomp.downcase.to_sym
      cohort = :november if cohort.empty?
      break if COHORT_LIST.include?(cohort)
      puts "Invalid cohort. Enter a month in full."
    end
    print "Age: "
    age = STDIN.gets.chomp.to_i
    print "Country: "
    country = STDIN.gets.chomp.init_caps
    print "Hobby: "
    hobby = STDIN.gets.chomp.init_caps
    students = insert_student(students, name, cohort, age, country, hobby)
    puts "Now we have #{students.count} student#{plural(students.count)}"
    name = STDIN.gets.chomp.init_caps
  end
  students
end

def save_students(students,filename=DEFAULT_FILE)
  file = File.open(filename,"w")
  students.each { |student| file.puts [student[:name],student[:cohort],student[:age],student[:country],student[:hobby]].join(",")}
  file.close
  puts "Saved #{students.count} student#{plural(students.count)} to #{filename}"
end

def load_students(students,filename=DEFAULT_FILE)
  if File.exists?(filename)
    file = File.open(filename,"r")
    prev_count = students.count
    file.readlines.each do |line|
      name, cohort, age, country, hobby = line.chomp.split(",")
      students = insert_student(students, name, cohort.to_sym, age.to_i, country.to_s, hobby.to_s)
    end
    file.close
    file_count = students.count - prev_count
    puts "#{prev_count == 0 ? "Loaded" : "Added"} #{file_count} student#{plural(file_count)} from #{filename}."
  else
    puts "Sorry, #{filename} does not exist"
  end
  students
end

def insert_student(students, name, cohort, age, country, hobby)
  students << {name: name, cohort: cohort.to_sym, age: age, country: country, hobby: hobby}
end

def plural(count)
  count == 1 ? "" : "s"
end

def try_load_students
  filename = ARGV.first || DEFAULT_FILE
  return if filename.nil?
  load_students([],filename)
end

def get_filename
  puts "Press enter to use file #{DEFAULT_FILE}. Enter filename otherwise."
  filename = gets.chomp
  filename.empty? ? DEFAULT_FILE : filename
end

students = try_load_students || []
loop do
  option = print_menu
  break if option == :exit
  students = process_students(students,option)
end
