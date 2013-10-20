module FacebookHelper
  PREPOSITIONS = %w(of van von de da do)
  def friend_name(friend)
    first, *middle, last = friend.name.split
    middle_initials = middle.map { |name|
      if PREPOSITIONS.member?(name.downcase)
        name
      else
        "#{name[0]}."
      end
    }.join(" ")

    "#{first} #{middle_initials} #{last}"
  end

  def cycle_stat_message
    message = t("user").keys.sample
    t("user.#{message}")
  end
end
