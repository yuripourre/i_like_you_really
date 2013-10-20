module ApplicationHelper
  def cache_key_for_friend_box(relationship)
    "friend-#{relationship.facebook_id}-#{relationship.friend_updated_at.to_i}"
  end

  def cache_key_for_relationship(relationship)
    "friend-#{relationship.id}-#{relationship.updated_at.to_i}"
  end

  def cache_key_for_latest_stats_update
    latest_update = current_user.relationships.maximum(:updated_at) ||
      Time.zone.now

    "stats-#{latest_update.to_i}"
  end

  def wizard_step_one_if_nothing_done_yet
    if current_user.still_needs_help_for("friends")
      render partial: "wizards/choose_friends"
    end
  end

  def wizard_step_two_if_not_hidden
    if current_user.still_needs_help_for("comments")
      render partial: "wizards/write_comments"
    end
  end
end
