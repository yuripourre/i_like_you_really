class RelationshipDecorator

  attr_reader :relationship
  def initialize(relationship)
    @relationship= relationship
  end

  def name
    @relationship.facebook_user.name
  end

  def image
    "https://graph.facebook.com/#{self.facebook_id}/picture?width=80&height=80"
  end

  def facebook_id
    @relationship.facebook_user_id

  end

  def like
    @relationship.like
  end

  def comment
    @relationship.comment
  end

  def like_class
    like ? "icon-thumbs-up" : "icon-thumbs-up-alt"
  end

  def comment_class
    like ? "icon-comments" : "icon-comments-alt"
  end

end
