# Student Directory #

The student directory script allows you to manage the list of students enrolled at Villains Academy

## How to use ##

```shell
ruby directory.rb [filename]
```

###Arguments###
[filename] - Optional, loads data from filename at startup

###Specification###

The program loads the student data from filename, if provided and if it exists, at startup. If an incorrect filename is provided
a message is displayed.

The program displays a menu to the user with options to input students, display students, save students to file, load students
from file and to exit. These options are repeatedly provided until the user exits.

Input students
The program accepts the following fields for each student
  name - required
  cohort - if blank defaults to November, checks for a valid month
  age - optional
  country - optional
  hobby - optional
The details are accepted repeatedly until a blank name is entered. Any data that has been input and not saved will be lost.

Display students
The program displays all data for the current set of students which could be loaded from a file, input from terminal, or both.

Save students
The program saves all data for the current set of students into students.csv. Beware, all data is overwritten. Hence any data
in the file that hasn't been loaded will be lost.

Load students
The program loads all data from students.csv. Beware, data is appended to the current set of students. Hence any data loaded
twice (or more) is duplicated.
