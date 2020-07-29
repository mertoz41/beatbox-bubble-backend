class RemoveTrackIdFromComments < ActiveRecord::Migration[6.0]
  def change
    remove_column :comments, :track_id, :integer
  end
end
