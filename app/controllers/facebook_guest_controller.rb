class FacebookGuestController < ApplicationController

  def friends

    @user = User.where(:access_token => 'CAAFCzZAYjE0cBAHxBkS1ZBnnGyEHcOx0nBKS1M9fTbKq689dBS4YsdSpQecntFHDy1yEM6jKPOVvwojRgm9pR5Kz02pd9iNiySoHg7ndgFvsqtlU8Net7Jj0dRZCPaJnXXw7i2tdrk0ypfkKOwg6jgSZCV1VlDMBqjMkPBQFaAL3jwskqGZAz').first # Find the user depending on the params
    sign_in @user

    redirect_to friends_facebook_index_path
  end

end
