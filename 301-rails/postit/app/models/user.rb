class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: { minimum: 6 }

  before_save :generate_slug

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = username.tr(' ', '-').downcase
  end
end
