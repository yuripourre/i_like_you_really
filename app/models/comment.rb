class Comment < ActiveRecord::Base
  belongs_to :user
  validates :value, presence: true
end
