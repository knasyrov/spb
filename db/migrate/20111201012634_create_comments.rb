class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :article
      t.references :user
      t.string :body
      t.timestamps
    end
  end
end
