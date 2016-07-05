require 'mongoid'

class Member
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic
end
