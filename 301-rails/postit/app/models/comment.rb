class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :commentor, foreign_key: 'user_id', class_name: 'User'
end
