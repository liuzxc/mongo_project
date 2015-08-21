class Article
  include Mongoid::Document
  field :title, type: String
  field :content, type: String
  field :category, type: String, default: 'diary'
  validates :title, presence: true

  embeds_many :comments
  belongs_to :user

  paginates_per 5
end
