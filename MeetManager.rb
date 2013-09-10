require 'MeetTask'
require 'MeetTextInterface'

class MeetManager

  attr_accessor :taskArray, :meet_text_interface, :task_length;
  
  def initialize	
    @taskArray = []
    @meet_text_interface = MeetTextInterface.new 
    50.times { print "*" }
    print "\nWelcome to the Meet Manager \n Type 'HELP' to see a list of Commands \n>"
    command = gets.strip.downcase.delete(' ')
    decide(command) 
  end

  def startDialogue
    print "\nWhat can I do for you? \n Type 'HELP' to see a list of Commands \n>"
    command = gets.strip.downcase.delete(' ')
    decide(command)
  end

  def decide(commandString)
    @task_length = @taskArray.length 
    case 
      when commandString == "help"then displayHelp

      when commandString == "addatask" then addATask
  
      when commandString == "displayalltasks" && @task_length >  0 then displayAllTasks   
  
      when commandString == "inspectatask" && @task_length > 0 then inspectATask
  
      when commandString  == "changeataskowner" && @task_length > 0 then changeATaskOwner
  
      when commandString == "changeataskduedate" && @task_length > 0 then changeATaskDueDate
  
      when commandString == "completeatask" && @task_length > 0 then completeATask
  
      when commandString == "removeatask" && @task_length > 0 then removeATask
  
      when commandString == "removealltasks" && @task_length > 0 then removeAllTasks
  
      when commandString == "addacomment" && @task_length > 0 then addAComment
        
      when commandString == "deleteacomment" && @task_length > 0 then deleteAComment

      when commandString == "duplicateatask" && @task_length > 0 then duplicateATask
  
      when commandString == "outputschedule" && @task_length > 0 then outputSchedule
    
    else 
     if @task_length == 0
      @meet_text_interface.add_task_first_error  
      startDialogue
     else
      @meet_text_interface.not_a_command_error
      startDialogue
    end
    end
  end

  def displayHelp
    @meet_text_interface.display_help
    startDialogue
  end

  def addATask
    print "Add A Task Owner\n>"
    taskOwner = gets.strip.split(" ").map {|w| w.capitalize }.join(" ")
    print "Add A Task\n>"
    toDo = gets.strip
    print "Add A Due Date\n>"
    due = gets.strip
    aTask = MeetTask.new(taskOwner, toDo, due)
    @taskArray.push(aTask)
    @task_length = @taskArray.length
    startDialogue
  end

  def displayAllTasks
    @taskArray.each { |task| 
    puts "\n Task Number: #{@taskArray.index(task)+1} \n Created At: #{task.createdAt} \n Task Owner: #{task.name}\n Task: #{task.task} \n Due Date: #{task.dueDate} \n Complete:   #{task.completed} \n Number of Comments: #{task.commentArray.size}  "
    task.commentArray.each { |comment|
    puts "\n  Commentor: #{comment.commentorName} \n  Created At: #{comment.time} \n  Comment: #{comment.comment} \n" 
      }
    }
    startDialogue
  end

  def inspectATask
    print "There Are #{@task_length} Total Tasks. Which Would You Like To Know More About\n>"
    taskNum = (gets.strip.to_i)
    if taskNum == 0 || taskNum > @task_length
      @meet_text_interface.out_of_bounds_error
      inspectATask
    end
    taskArrayIndex = taskNum - 1
    @taskArray[taskArrayIndex].taskInfo
    startDialogue
  end

  def changeATaskOwner
    print "There Are #{@task_length} Total Tasks. Which Task Would You Like To Reassign?\n>"
    taskNum = (gets.strip.to_i)
    if taskNum == 0 || taskNum > @task_length
      @meet_text_interface.out_of_bounds_error
      changeATaskOwner
    end
    taskArrayIndex = taskNum - 1
    @taskArray[taskArrayIndex].changeTaskOwner
    startDialogue
  end

  def changeATaskDueDate
    print "There Are #{@task_length} Total Tasks. Which Tasks Due Date Do You Want To Change?\n>"
    taskNum = (gets.strip.to_i)
    if taskNum == 0 || taskNum > @task_length
      @meet_text_interface.out_of_bounds
      changeATaskDueDate
    end
    taskArrayIndex = taskNum - 1
    @taskArray[taskArrayIndex].changeDueDate
    startDialogue
  end

  def completeATask
    print "There Are #{@task_length} Total Tasks. Type In The Number Of The Task To Complete?\n>"
    taskNum = (gets.strip.to_i)
    if taskNum == 0 || taskNum > @task_length 
      @meet_text_interface.out_of_bounds_error 
      completeATask
    end
    taskArrayIndex = taskNum - 1
    @taskArray[taskArrayIndex].markComplete
    startDialogue
  end

  def removeATask
    print "There Are #{@task_length} Total Tasks. Type In The Number Of The Task To Delete?\n>"
    taskNum = (gets.strip.to_i)
    if taskNum == 0 || taskNum > @task_length
      @meet_text_interface.out_of_bounds_error
      removeATask
    end
    taskArrayIndex = taskNum - 1
    @taskArray.delete_at(taskArrayIndex)
    puts "Task number #{taskNum} is deleted!"
    startDialogue
  end

  def addAComment
    print "There Are #{@task_length} Total Tasks. Type In The Number Of The Task To Add A Comment?\n>"
    taskNum = (gets.strip.to_i)
    if taskNum == 0 || taskNum > @task_length 
      @meet_text_interface.out_of_bounds_error
      addAComment
    end
    taskArrayIndex = taskNum - 1
    @taskArray[taskArrayIndex].add_comment
    startDialogue
  end
  
  def deleteAComment
    print "There Are #{@task_length} Total Tasks. Type In The Number Of The Task With The Comment You Want To Delete?\n>"
    taskNum = (gets.strip.to_i)
    if taskNum == 0 || taskNum > @task_length
      @meet_text_interface.out_of_bounds_error
      deleteAComment
    end
    taskNum = taskNum - 1
    @taskArray[taskNum].delete_comment
    startDialogue
  end

  def removeAllTasks
    @taskArray.clear
    puts "All Tasks Removed! Make sure you stock up on more meet."
    startDialogue
  end
  
  def duplicateATask
    puts "What Meet Do You Want To Duplicate? You have #{@task_length } to duplicate."
    taskNum = (gets.strip.to_i)
    if taskNum == 0 || taskNum > @task_length
      @meet_text_interface.out_of_bounds_error
      startDialogue
    end
    taskArrayIndex = taskNum - 1
    dup = MeetTask.new(@taskArray[taskArrayIndex].name, @taskArray[taskArrayIndex].task, @taskArray[taskArrayIndex].dueDate, @taskArray[taskArrayIndex].commentArray);
    @taskArray.push(dup);
    startDialogue   
 end

  def outputSchedule
    print "Name This file \n>"
    fileName = gets.strip.delete(' ');
    outFile = File.new("#{fileName}.txt", "w")
    outString = @taskArray.each { |info| outFile.puts "\nTask Number: #{@taskArray.index(info)+1} \nTask Owner: #{info.name}\nCreated at: #{info.createdAt} \nTask: #{info.task} \nDue Date: #{info.dueDate} \nComplete: #{info.completed} \nNumber of Comments: #{info.commentArray.size}\nComment:"
      info.commentArray.each { |comment|
        outFile.puts "\nCommentor: #{comment.commentorName} \nCreated At: #{comment.time} \nComment: #{comment.comment} \n\n" 
      }
    }
    outFile.close
    startDialogue
  end

end

  porkChop = MeetManager.new
=======
=======
>>>>>>> eeac058d0d1ffa37aa694a47289a3daa1a6f946a
=======
>>>>>>> eeac058d0d1ffa37aa694a47289a3daa1a6f946a
attr_accessor :taskArray

def initialize	
 @taskArray = []
 50.times { print "*" }
 print "\nWelcome to the Meet Manager \n Type 'HELP' to see a list of Commands \n>"
 command = gets.strip.downcase.delete(' ')
 decide(command) 
end

def startDialogue
 print "\nWhat can I do for you? \n Type 'HELP' to see a list of Commands \n>"
 command = gets.strip.downcase.delete(' ')
 decide(command)
end

def decide(commandString)
 @totalTasks = @taskArray.length

 command = commandString
 case 
  when command == "help" then displayHelp

  when command == "addatask" then addATask
  
  when command == "displayalltasks" && @totalTasks > 0 then displayAllTasks
  
  when command == "inspectatask" && @totalTasks > 0 then inspectATask
  
  when command  == "changeataskowner"  && @totalTasks > 0 then changeATaskOwner
  
  when command == "changeataskduedate" && @totalTasks > 0 then changeATaskDueDate
  
  when command == "completeatask" && @totalTasks > 0 then completeATask
  
  when command == "removeatask" && @totalTasks > 0 then removeATask
 
  when command == "removealltasks" && @totalTasks > 0 then removeAllTasks
 
  when command == "addacomment" && @totalTasks > 0 then addAComment
 
  when command == "outputschedule" && @totalTasks > 0 then outputSchedule
    
  else 
    if@totalTasks == 0
      puts "You Need To Add A Task First!"
      startDialogue 
   else
      puts "Quit mishandling the meet."
      startDialogue
   end
 end
end

def displayHelp
 puts "\n To add a task type -- 'Add A Task' \n 
 To display all tasks type -- 'Display All Tasks' \n
 To get all the info for a task type -- 'Inspect A Task' \n 
 To change the owner of a task type -- 'Change A Task Owner' \n
 To change a task due date type -- 'Change A Task Due Date' \n 
 To mark a task as complete type -- 'Complete A Task' \n
 To remove a task from the list type -- 'Remove A Task' \n
 To remove all of the tasks from the list type -- 'Remove All Tasks' \n
 To add a comment to a task type -- 'Add A Commnet' \n
 To output the schedule to a file type -- 'Output Schedule' \n\n"
 startDialogue
end

def addATask
 print "Add A Task Owner\n>"
 taskOwner = gets.strip.split(" ").map {|w| w.capitalize }.join(" ")
 print "Add A Task\n>"
 toDo = gets.strip
 print "Add A Due Date\n>"
 due = gets.strip
 aTask = MeetTask.new(@taskCount,taskOwner, toDo, due)
 @taskArray.push(aTask)
 startDialogue
end

def displayAllTasks
 @taskArray.each { |task| 
  puts "\n Task Number: #{@taskArray.index(task)+1} \n Created At: #{task.createdAt} \n Task Owner: #{task.name}\n Task: #{task.task} \n Due Date: #{task.dueDate} \n Complete:   #{task.completed} \n Number of Comments: #{task.commentArray.size}  "
  task.commentArray.each { |comment|
    puts "\n Commentor: #{comment.commentorName} \n Created At: #{comment.time} \n Comment: #{comment.comment} \n" 
  }
 }
 startDialogue
end

def inspectATask
 totalTasks = @taskArray.length
 print "There Are #{totalTasks} Total Tasks. Which Would You Like To Know More About\n>"
 taskNum = (gets.strip.to_i)
 if taskNum == 0 || taskNum > totalTasks 
  puts "That is not a valid number, you should check your cuts of meet before you step up to the counter."
  inspectATask
 end
  taskArrayIndex = taskNum - 1
  @taskArray[taskArrayIndex].taskInfo
  startDialogue
end

def changeATaskOwner
 totalTasks = @taskArray.length
 print "There Are #{totalTasks} Total Tasks. Which Task Would You Like To Reassign?\n>"
 taskNum = (gets.strip.to_i)
 if taskNum == 0 || taskNum > totalTasks 
  puts "That is not a valid number, if you are looking for veggies they are not here."
  changeATaskOwner
 end
 taskArrayIndex = taskNum - 1
 @taskArray[taskArrayIndex].changeTaskOwner
 startDialogue
end

def changeATaskDueDate
 totalTasks = @taskArray.length
 print "There Are #{totalTasks} Total Tasks. Which Tasks Due Date Do You Want To Change?\n>"
 taskNum = (gets.strip.to_i)
 if taskNum == 0 || taskNum > totalTasks 
  puts "That is not a valid number, look I don't got all day is it gonna be chops, or loins?"
  changeATaskDueDate
 end
 taskArrayIndex = taskNum - 1
 @taskArray[taskArrayIndex].changeDueDate
 startDialogue
end

def completeATask
 totalTasks = @taskArray.length
 print "There Are #{totalTasks} Total Tasks. Type In The Number Of The Task To Complete?\n>"
 taskNum = (gets.strip.to_i)
 if taskNum == 0 || taskNum > totalTasks 
 puts "That is not a valid number, I want to get you out of here too what meet do you want?"
 completeATask
 end
 taskArrayIndex = taskNum - 1
 @taskArray[taskArrayIndex].markComplete
 startDialogue
end

def removeATask
 totalTasks = @taskArray.length
 print "There Are #{totalTasks} Total Tasks. Type In The Number Of The Task To Delete?\n>"
 taskNum = (gets.strip.to_i)
 if taskNum == 0 || taskNum > totalTasks 
  puts "That is not a valid number, what do you want to order?"
  removeATask
 end
  taskArrayIndex = taskNum - 1
  @taskArray.delete_at(taskArrayIndex)
  puts "Task number #{taskNum} is deleted!"
  startDialogue
end

def addAComment
 totalTasks = @taskArray.length
 print "There Are #{totalTasks} Total Tasks. Type In The Number Of The Task To Add A Comment?\n>"
 taskNum = (gets.strip.to_i)
 if taskNum == 0 || taskNum > totalTasks 
  puts "That is not a valid number, we got lamb chops we got pork chops we don't got that chop"
  addAComment
 end
  taskArrayIndex = taskNum - 1
  @taskArray[taskArrayIndex].comment
  startDialogue
end

def removeAllTasks
 @taskArray.clear
 @taskCount = 1
 puts "All Tasks Removed! Make sure you stock up on more meet."
 startDialogue
end

def outputSchedule
 print "Name This file \n>"
 fileName = gets.strip.delete(' ');
 outFile = File.new("#{fileName}.txt", "w")
 outString = @taskArray.each { |info| outFile.puts "\nTask Number: #{@taskArray.index(info)+1} \nTask Owner: #{info.name}\nCreated at: #{info.createdAt} \nTask: #{info.task} \nDue Date: #{info.dueDate} \nComplete: #{info.completed} \nNumber of Comments: #{info.commentArray.size}\nComment:"
 info.commentArray.each { |comment|
   outFile.puts "\nCommentor: #{comment.commentorName} \nCreated At: #{comment.time} \nComment: #{comment.comment} \n\n" 
  }
 }
 outFile.close
 startDialogue
end
end


porkChop = MeetManager.new
