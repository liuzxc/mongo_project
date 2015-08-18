class Article
  include Mongoid::Document
  field :title, type: String
  field :content, type: String
  field :category, type: String, default: 'diary'
  validates :title, presence: true

  embeds_many :comments
end
