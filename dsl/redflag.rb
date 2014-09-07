# def event(description)
#   puts "ALERT: #{description}" if yield
# end

def setup(&block)
  @setups << block
end

def event(description, &block)
  @events << {description: description, condition: block}
end

# Instance variables set in the main scope, act like global variables
@setups = []
@events = []
load 'events.rb'

@events.each do |event|
  @setups.each do |setup|
    setup.call
  end
  puts "ALERT: #{event[:description]}" if event[:condition].call
end
