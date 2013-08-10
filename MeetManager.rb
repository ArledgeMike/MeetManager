require 'MeetTask'

class MeetManager

attr_accessor :taskArray, :taskCount

def initialize	
 puts "Welcome to the Meet Manager \n Type HELP to see a list of Commands \n"
 @taskArray = []
 @taskCount = 1;
 startDialogue
end

def startDialogue
 puts "What can I do for you?"
 command = gets.strip.downcase.delete(' ')
#puts command
 decide(command)
end

def decide(commandString)
 command = commandString
 case 
  when command == "help"
  displayHelp

  when command == "addatask"
  addATask
  
  when command == "displayalltasks"
  displayAllTasks
 
  when command == "inspectatask"
  inspectATask

  when command  == "changeataskowner"
  changeATaskOwner

  when command == "changeataskduedate"
  changeATaskDueDate

  when command == "completeatask"
  completeATask

  when command == "removeatask"
  removeATask

  when command == "removealltasks"
  removeAllTasks

  when command == "addacomment"
  addAComment

  when command == "outputschedule"
  outputSchedule  
 else 
  puts "That is not a command. You are just making things up. \n Type HELP if you don't know what you are doing."
 s startDialogue
 end
end

def displayHelp
 puts "To add a task type -- Add A Task \n To display all tasks type -- Display All Tasks \n To get all the info for a task type -- Inspect A Task \n To change the owner of a task type -- Change A Task Owner \n To change a task due date type -- Change A Task Due Date \n To mark a task as complete type -- Complete A Task \n To remove a task from the list type -- Remove A Task \n To remove all of the tasks from the list type -- Remove All Tasks \n"
 startDialogue
end

def addATask
 puts "Add A Task Owner\n"
 taskOwner = gets.strip
 puts "Add A Task\n"
 toDo = gets.strip
 puts "Add A Due Date\n"
 due = gets.strip
 aTask = MeetTask.new(@taskCount,taskOwner, toDo, due)
 @taskArray.push(aTask)
 @taskCount = @taskCount +1
 startDialogue
end

def displayAllTasks
puts @taskArray 
@taskArray.each { |task| 
  puts "\n Task Number #{@taskArray.index(task)+1} \n Name: #{task.name}\n Task: #{task.task} \n Due Date: #{task.dueDate} \n Complete:   #{task.completed} \n "
  task.commentArray.each { |comment|
    puts "Comment: #{comment.comment} \n\n" 
  }
}
 startDialogue
end

def inspectATask
 totalTasks = @taskArray.length
 puts "There Are #{totalTasks} Total Tasks. Which Would You Like To Know More About\n"
 taskNum = (gets.strip.to_i)
 if (taskNum == 0)
  puts "You did that wrong. Enter the number of the task you want to inspect"
  inspectATask
 end
  taskArrayIndex = taskNum - 1
  @taskArray[taskArrayIndex].taskInfo
  startDialogue
end

def changeATaskOwner
 totalTasks = @taskArray.length
 puts "There Are #{totalTasks} Total Tasks. Which Task Would You Like To Reassign?\n"
 taskNum = (gets.strip.to_i)
 if (taskNum == 0)
  puts "That is not a valid number"
  changeATaskOwner
 end
 taskArrayIndex = taskNum - 1
 @taskArray[taskArrayIndex].changeTaskOwner
 startDialogue
end

def chanageATaskDueDate
 totalTasks = @taskArray.length
 puts "There Are #{totalTasks} Total Tasks. Which Tasks Due Date Do You Want To Change?\n"
 taskNum = (gets.strip.to_i)
 if (taskNumer == 0)
  puts "That is not a valid number"
  changeATaskDueDate
 end
 taskArrayIndex = taskNum - 1
 @taskArray[taskArrayIndex].changeDueDate
 startDialogue
end

def completeATask
 totalTasks = @taskArray.length
 puts "There Are #{totalTasks} Total Tasks. Type In The Number Of The Task To Complete?\n"
 taskNum = (gets.strip.to_i)
 if (taskNum == 0)
 puts "Type in the number of the task you want to mark as complete"
 completeATask
 end
 taskArrayIndex = taskNum - 1
 @taskArray[taskArrayIndex].markComplete
 puts "Task number #{taskNum} is completed" 
 startDialogue
end

def removeATask
 totalTasks = @taskArray.length
 puts "There Are #{totalTasks} Total Tasks. Type In The Number Of The Task To Delete?\n"
 taskNum = (gets.strip.to_i)
 if (taskNum == 0) 
  puts "That is not a number try again"
  removeATask
 end
  taskArrayIndex = taskNum - 1
  @taskArray.delete_at(taskArrayIndex)
  puts "Task number #{taskNum} is deleted"
  @taskCount = @taskCount -1
  startDialogue
end

def addAComment
 totalTasks = @taskArray.length
 puts "There Are #{totalTasks} Total Tasks. Type In The Number Of The Task To Add A Comment?\n"
 taskNum = (gets.strip.to_i)
 if (taskNum == 0) 
  puts "That is not a number try again"
  addAComment
 end
  taskArrayIndex = taskNum - 1
  @taskArray[taskArrayIndex].comment
  
  startDialogue

end

def removeAllTasks
 @taskArray.clear
 @taskCount = 1
 puts "All Tasks Removed"
 startDialogue
end

def outputSchedule
 puts "Name This file \n"
 fileName = gets.strip.delete(' ');
outFile = File.new("#{fileName}.txt", "w")
 outString = @taskArray.each { |info| outFile.puts "Task Owner: #{info.name} \n Task Information #{info.task} \n Due Date:  #{info.dueDate} \n\n\n"  }
outFile.close
end


end
