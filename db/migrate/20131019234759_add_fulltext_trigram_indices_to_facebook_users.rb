class AddFulltextTrigramIndicesToFacebookUsers < ActiveRecord::Migration
  def change
    execute "CREATE INDEX ON facebook_users using gist (name gist_trgm_ops);"
  end
end
