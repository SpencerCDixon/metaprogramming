# Version 1
# def event(description)
#   puts "ALERT: #{description}" if yield
# end
#


# Version 2
# def setup(&block)
#   @setups << block
# end
#
# def event(description, &block)
#   @events << {description: description, condition: block}
# end
#
# @setups = []
# @events = []
# load 'events.rb'
#
# @events.each do |event|
#   @setups.each do |setup|
#     setup.call
#   end
#   puts "ALERT: #{event[:description]}" if event[:condition].call
# end
#

lambda {
  setups = []
  events = []

  Kernel.send :define_method, :setup do |&block|
    setups << block
  end

  Kernel.send :define_method, :event do |description, &block|
    events << {description: description, condition: block}
  end

  Kernel.send :define_method, :each_setup do |&block|
    setups.each do |setup|
      block.call setup
    end
  end

  Kernel.send :define_method, :each_event do |&block|
    events.each do |event|
      block.call event
    end
  end
}.call

# by calling it immediately it defines the methods in kernel


load 'events.rb'

each_event do |event|
  each_setup do |setup|
    setup.call
  end
  puts "ALERT: #{event[:description]}" if event[:condition].call
end
