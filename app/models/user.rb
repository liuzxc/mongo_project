class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time
  include ActiveModel::SecurePassword

  field :user_name, type: String
  field :email, type: String
  field :password_digest, type: String
  field :admin, type: Boolean, default: false
  field :avatar_url, type: String
  field :location, type: String, default: 'Chengdu'
  field :created_at, type: Time, default: Time.now
  field :github_id, type: Integer
  field :stack_id, type: Integer

  validates :user_name, :email, presence: true
  validates :user_name, uniqueness: {message: "该用户名已经被占用"}
  validates :email,     uniqueness: {message: "该邮箱已经注册过"}
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, message: "邮箱格式不符"
  validates :user_name, length: { minimum: 3,  too_short: "用户名长度不少于%{count}个字符" }
  validates :password,  length: { minimum: 6,  too_short: "密码长度不少于%{count}个字符" }

  has_many :articles, dependent: :destroy
  has_many :favorites
  has_many :likes

  has_secure_password
end
