class CreateTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :tracks do |t|
      t.string :name
      t.string :blob
      t.integer :user_id

      t.timestamps
    end
  end
end
