class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :posts, through: :categorizations

  before_save :generate_slug

  validates :name, presence: true

  def to_param
    slug
  end

  private

  def generate_slug
    self.slug = name.tr(' ', '-').downcase
  end
end
