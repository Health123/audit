class CreateSecrets < ActiveRecord::Migration
  def change
    create_table :secrets do |t|
      t.string :data
      t.integer :user_id

      t.timestamps
    end
  end
end
