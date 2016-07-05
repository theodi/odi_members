require 'mongoid'

class Organisation
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

#  field :name,       type: String
#  field :id,         type: Numeric
#  field :pictureUrl, type: String
#  field :createdOn,  type: DateTime
#  field :updatedOn,  type: DateTime
end
