class Comment
  include Mongoid::Document
  field :name, type: String
  field :content, type: String
  field :created_at, type: Time, default: Time.now

  embedded_in :article, inverse_of: :comments
end
