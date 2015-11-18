class User
  include Mongoid::Document
  include ActiveModel::SecurePassword

  field :user_name, type: String
  field :email, type: String
  field :password_digest, type: String
  field :admin, type: Boolean, default: false
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
  field :avatar, type: String
=======
  field :avatar_url, type: String
>>>>>>> b3b7667... 去掉无用的代码
=======
  field :avatar_url, type: String
>>>>>>> c9ec5ef... 使用 gravatar 生成用户头像
=======
  field :avatar_url, type: String
>>>>>>> 60bef676c588b3c186e743e0afdd210e4abf16c2

  # attr_accessor :password, :password_confirmation

  has_many :articles, dependent: :destroy

  has_secure_password
end
