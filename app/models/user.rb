class User
  include Mongoid::Document
  include ActiveModel::SecurePassword

  field :user_name, type: String
  field :email, type: String
  field :password_digest, type: String
  field :admin, type: Boolean, default: false
  field :avatar_url, type: String

  # attr_accessor :password, :password_confirmation

  has_many :articles, dependent: :destroy

  has_secure_password
end
