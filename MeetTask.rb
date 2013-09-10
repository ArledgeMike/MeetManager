require 'MeetComment'

class MeetTask
  

attr_accessor :name, :task, :dueDate, :completed, :createdAt, :commentArray

  def initialize( name, task, dueDate, commentArray=[])
    @name = name
    @task = task
    @dueDate = dueDate
    @completed = false
    @createdAt = Time.new
    @commentArray = commentArray;
    puts "New Meet Succesfully Added!"
  end

  def markComplete
    @completed = true
    puts "This task is completed!" 
  end

  def taskInfo
    puts "\n Task Owner: #{name} \n Created at: #{@createdAt} \n Task: #{task} \n Due Date: #{dueDate} \n Complete:  #{@completed} \n Number of Comments: #{@commentArray.size} \n Comments: \n"
    @commentArray.each { |comment| puts "\n Name: #{comment.commentorName} \n Created At: #{comment.time} \n Comment: #{comment.comment}" }
  end
 
  def changeTaskOwner
    print "Enter A New Owner For This Task\n>"
    newOwner = gets.strip
    @name = newOwner;
    puts "Owner Transfered Succesfully!" 
  end

  def changeDueDate
    print "Enter A New Due Date For This Task\n>"
    newDate = gets.strip
    @dueDate = newDate
    puts "Due Date Changed Succesfully!"
  end

  def add_comment
    print "Enter Commentors Name\n>"
    theCommentor = gets.strip.split(" ").map { |w| w.capitalize }.join(" ")
    print "Enter A Comment \n>"
    theComment = gets.strip
    aComment = MeetComment.new(theCommentor, theComment)
    @commentArray.push(aComment); 
  end
  
  def delete_comment
    @commentArray.each { |comment| puts "\n Name: #{comment.commentorName} \n Created At: #{comment.time} \n Comment: #{comment.comment}" }
    print "Which Comment Would You Like To Delete?\n>"
    comment_num = (gets.strip.to_i)
    comment_num = comment_num - 1
    @commentArray.delete_at(comment_num);
    puts "That Meet's Comment Has Been Removed!"
  end

end
