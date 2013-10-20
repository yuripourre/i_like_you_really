class Activity <ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "FacebookUser", foreign_key: :friend_id
  # category, value, friend_id, object_id

  scope :likes, -> { where(like: true) }
  scope :comments, -> { where(comment: true) }
  scope :latest, -> { order("updated_at DESC") }
end
