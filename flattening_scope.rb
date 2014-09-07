my_variable = "Success!"

MyClass = Class.new do
  puts "#{my_variable}"

  define_method :my_method do
    "#{my_variable} inside a method"
  end
end

MyClass.new
puts MyClass.new.my_method

# You can replace the scope gate with a method call, capture the current bindings in a closure, and pass the closure to the method.
