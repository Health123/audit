class CreateAuditTables < ActiveRecord::Migration
  def up
    create_table :audit_logs do |t|
      t.integer   :auditable_id
      t.string    :auditable_type
      t.integer   :user_id
      t.string    :user_type
      t.string    :ip_address
      t.string    :action
      t.timestamps
    end
    
    add_index :audit_logs, [:auditable_id, :auditable_type], :name => 'auditable_index'
    add_index :audit_logs, [:user_id, :user_type], :name => 'user_index'
    add_index :audit_logs, :created_at
  end

  def down
    remove_index :audit_logs, :name => 'auditable_index'
    remove_index :audit_logs, :name => 'user_index'
    remove_index :audit_logs, :column => :created_at
    
    drop_table :audit_logs
  end
end