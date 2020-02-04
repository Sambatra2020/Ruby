require "pry"

class User
	attr_accessor :prenom
	

  def set_name_to(some_string)
    @name = some_string
  end

  def get_name
    return @name
  end

  def greet
    puts "Hi! My name is #{@name}!"
  end

end
binding.pry

puts "end of file"