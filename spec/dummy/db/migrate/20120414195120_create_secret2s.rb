class CreateSecret2s < ActiveRecord::Migration
  def change
    create_table :secret2s do |t|
      t.integer :user_id
      t.text :data

      t.timestamps
    end
  end
end
