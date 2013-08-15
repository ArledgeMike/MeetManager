class MeetComment
attr_accessor :commentorName, :comment, :time
  def initialize( name, comment)
    @commentorName = name
    @comment = comment
    @time = Time.new
    puts "Comment added successfully!"
 end
end
