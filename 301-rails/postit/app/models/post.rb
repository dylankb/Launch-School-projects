class Post < ActiveRecord::Base
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  has_many :comments
  has_many :categorizations
  has_many :categories, :through => :categorizations

  validates :title, presence: true, length: { minimum: 5 }
  validates :url, presence: true
  validates :description, presence: true, uniqueness: true
end
