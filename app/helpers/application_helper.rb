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

  def help_message_for(name)
    if current_user.still_needs_help_for(name)
      render partial: "wizards/#{name}"
    end
  end
end
