class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.references :user
      t.string :title, :null => false
      t.text :body
      t.timestamps
    end
  end
end
