require 'pry'

class SimpleBaseClass
  @base_class = []

  class << self
    attr_reader :base_class
  end

  def self.inherited(subclass)
    @base_class << subclass
  end
end

class ChildClassOne < SimpleBaseClass
end

class ChildClassTwo < SimpleBaseClass
end


base = SimpleBaseClass.new
base.class.base_class # => [ChildClassOne, ChildClassTwo]
SimpleBaseClass.base_class # => [ChildClassOne, ChildClassTwo]

module IncludedModule
  def self.included(klass)
    puts "Hey, I've been included in #{klass}"
  end
end

=begin
A common pattern is to extend class methods from an included hook in a module
that way your original class stays clean.
=end

module UsefulMethods
  module ClassMethods
    def a_class_method
    end
  end

  def self.included(klass)
    klass.extend(ClassMethods)
  end

  def an_instance_method
  end
end

class Host
  include UsefulMethods
end

