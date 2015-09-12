class Comment
  include Mongoid::Document
  include SoftDelete
  field :name, type: String
  field :content, type: String
  field :floor, type: Integer

  embedded_in :article, inverse_of: :comments
end
