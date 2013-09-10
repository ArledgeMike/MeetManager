class MeetTextInterface

  def initialize

  end
 
  def display_help
 puts "\n To add a task type -- 'Add A Task' \n 
 To display all tasks type -- 'Display All Tasks' \n
 To get all the info for a task type -- 'Inspect A Task' \n 
 To change the owner of a task type -- 'Change A Task Owner' \n
 To change a task due date type -- 'Change A Task Due Date' \n 
 To mark a task as complete type -- 'Complete A Task' \n
 To remove a task from the list type -- 'Remove A Task' \n
 To remove all of the tasks from the list type -- 'Remove All Tasks' \n
 To add a comment to a task type -- 'Add A Commnet' \n
 To remove a comment from a task type -- 'Remove A Task' \n
 To duplicate a task type -- 'Duplicate A Task' \n
 To output the schedule to a file type -- 'Output Schedule' \n\n"
  end
 
  def out_of_bounds_error
    puts "That meet does not exist"
  end

  def add_task_first_error
    puts "You haven't added any meets yet. You should start by adding a few meets."
  end

  def not_a_command_error
    puts "Thats not how you handle the meets."
  end
  
  def custom_error(custom_string)
    puts custom_string
  end
  
end
