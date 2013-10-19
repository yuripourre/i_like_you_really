class Friend < ActiveRecord::Base
  belongs_to :user
  has_many :posts

  validates :token, uniqueness: {scope: :user_id}, presence: true
  validates :user_id, presence: true
end
