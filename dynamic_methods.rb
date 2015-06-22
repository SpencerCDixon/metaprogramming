require 'pry'

class FormBuilder

  def initialize(args)
    @type = args[:type]
    @name = args[:name]
  end

  def self.define_tag(type)
    define_method(type) do
     "<input type='#{@type}' name='#{@name}'>"
    end
  end

  define_tag :text
end

text = {
  type: "Text",
  name: "username"
}

tag = FormBuilder.new(text)
puts tag.text

