module DashboardHelper
  def css_class_for_like(activity)
    if activity.like?
      "icon-thumbs-up done"
    else
      "icon-thumbs-up-alt"
    end
  end

  def css_class_for_comment(activity)
    if activity.comment?
      "icon-comment done"
    else
      "icon-comment-alt"
    end
  end
end
