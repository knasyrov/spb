class AddDeviseToUsers < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.database_authenticatable :null => false
      t.trackable
      # t.token_authenticatable
    end

    add_index :users, :email,                :unique => true
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration   
  end
end
