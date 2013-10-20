class AddFulltextIndicesToFriends < ActiveRecord::Migration
  def change
    execute "CREATE INDEX ON facebook_users using gin(to_tsvector('english', name));"
  end
end
