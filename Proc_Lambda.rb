require 'pry'

# Creating blocks that are usable elsewhere 

l = lambda {|x| x + 1}

# OR

o = ->(x) {x + 1}


# Passing in blocks to methods:

def math(a, b)
  yield(a, b)
end

def do_math(a, b, &operation)
  math(a, b, &operation)
end

puts do_math(2, 3) {|x, y| x * y}
