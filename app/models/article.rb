class Article
  include Mongoid::Document
  field :title, type: String
  field :content, type: String
  field :category, type: String, default: 'diary'
  validates :title, presence: true

  embeds_many :comments
  belongs_to :user

  paginates_per 5


  def self.search(search_param)
    any_of({title: /#{search_param}/i}, {content: /#{search_param}/i})
  end

end
