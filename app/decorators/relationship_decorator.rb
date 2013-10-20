class RelationshipDecorator < SimpleDelegator
  def name
    facebook_user.name
  end

  def image
    "https://graph.facebook.com/#{self.facebook_id}/picture?width=80&height=80"
  end

  def facebook_id
    facebook_user_id
  end

  def like_class
    like ? "icon-thumbs-up" : "icon-thumbs-up-alt"
  end

  def comment_class
    comment ? "icon-comments" : "icon-comments-alt"
  end

  def friend_updated_at
    facebook_user.updated_at
  end
end
