require 'mongoid'

class Person
  include Mongoid::Document

  field :name,  type: String
  field :age ,  type: Numeric
end
