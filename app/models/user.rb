class User
  include Mongoid::Document
  field :user_name, type: String
  field :email, type: String
  has_many :articles
end
