# Using method_missing for delegation

class Document
  attr_reader :title, :body
  def initialize(title, body)
    @title, @body = title, body
  end

  def content
    @title + @body
  end
end

class SuperSecretDocument
  DELEGATED_METHODS = [:content, :title]

  def initialize(original_document, time_to_see)
    @original_document = original_document
    @time_to_see = time_to_see
    @create_time = Time.now
  end

  def time_expired?
    Time.now - @create_time >= @time_to_see
  end

  def check_for_expiration
    raise 'Document no longer available' if time_expired?
  end

  def method_missing(name, *args)
    check_for_expiration

    # only let some methods be delegated
    if DELEGATED_METHODS.include?(name)
      @original_document.send(name, *args)
    else
      super
    end
  end
end

document = Document.new('title', ' body')

super_secret = SuperSecretDocument.new(document, 10)
puts super_secret.content

# How OStruct uses method_missing to either set or retrieve an element:
=begin
def method_missing(mid, *args)
  mname = mid.id2name
  len = args.length

  if mname =~ /=$/
    mname.chop!
    self.new_ostruct_member(mname)
    @table[mname.intern] = args[0]
  elsif
    @table[mid]
  else
    raise NoMethodError,
      "undefined method #{mname} for #{self}, caller(1)
  end
=end
