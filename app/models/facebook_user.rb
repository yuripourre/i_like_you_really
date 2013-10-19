class FacebookUser < ActiveRecord::Base
  validates :facebook_id, uniqueness: true, presence: true
  has_many :relationships
  self.primary_key = "facebook_id"
end
