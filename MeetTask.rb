require 'MeetComment'

class MeetTask
attr_accessor :name, :task, :dueDate, :completed, :counter, :commentArray

def initialize(idNumber, name, task, dueDate)
 @name = name
 @task = task
 @dueDate = dueDate
 @completed = false
 @counter = idNumber;
 @commentArray = [];
 puts "New Task Succesfully Added"
end

def markComplete
 @completed = true
end

def taskInfo
 puts "This task belongs to #{name} they need to #{task} and have this completed by #{dueDate} is this task complete? #{@completed}"
 @commentArray.each { |comment| puts "Name: #{comment.commentorName} at #{comment.time} \n Commented: #{comment.comment}" }
end
 
def changeTaskOwner
 puts "Enter A New Owner For This Task\n"
 newOwner = gets.strip
 @name = newOwner;
end

def changeDueDate
 puts "Enter A New Due Date For This Task"
 newDate = gets.strip
 @dueDate = newDate
end

def comment
 puts "Enter Commentors Name"
 theCommentor = gets.strip
 puts "Enter A Comment \n"
 theComment = gets.strip
 aComment = MeetComment.new(theCommentor, theComment)
 @commentArray.push(aComment); 
end



end


