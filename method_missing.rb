# Using the text gem and soundex to give
# intelligent method_missing error handling:

require 'text'

class Document
  include Text

  # meat of class omitted

  def method_missing(missing, *args)
    candidates = methods_that_sound_like(missing.to_s)

    message = "You called an undefined method: #{missing}"

    unless candidates.empty?
      message += "\nDid you mean #{candidates.join(' or ')}?"
    end

    raise NoMethodError.new(message)
  end

  def methods_that_sound_like(name)
    missing_soundex = Soundex.soundex(name.to_s)
    pubic_methods.sort.find_all do |existing|
      existing_soundex = Soundex.soundex(existing.to_s)
      missing_soundex == existing_soundex
    end
  end
end

document = Document.new
document.contnt

# => You called an undefined method: count
#    Did you mean content or content=?
#

=begin
Using const_missing to autoload like in rails
=end

def self.const_missing(name)
  file_name = name.to_s.downcase
  require file_name
  raise "Undefined: #{name}" unless const_defined?(name)
  const_get(name)
end
