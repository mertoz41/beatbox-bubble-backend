class AddSongIdToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :song_id, :integer
  end
end
