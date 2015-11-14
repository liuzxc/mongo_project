class Like
  include Mongoid::Document
  belongs_to :user
  belongs_to :article
end