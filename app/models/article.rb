class Article
  include Mongoid::Document
  field :title, type: String
  field :content, type: String
  field :category, type: String, default: 'diary'

  validates :title, presence: true

  embeds_many :comments
  belongs_to :user

  paginates_per 10

  CATEGORY = %w(
                技术文章
                日记
                随便写写
                )


  def self.search(search_param)
    any_of({title: /#{search_param}/i}, {content: /#{search_param}/i})
  end

  def self.number(category)
    where(category: category).count.to_i
  end

end
