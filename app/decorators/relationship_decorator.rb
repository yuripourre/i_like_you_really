class RelationshipDecorator < SimpleDelegator
  def name
    facebook_user.name
  end

  def image(width = 80, height = 80)
    "https://graph.facebook.com/#{self.facebook_id}/picture?width=#{width}&height=#{height}"
  end

  def facebook_id
    facebook_user_id
  end

  def friend
    facebook_user
  end

  def like_class
    like ? "icon-thumbs-up" : "icon-thumbs-up-alt"
  end

  def comment_class
    comment ? "icon-comments" : "icon-comments-alt"
  end
end
