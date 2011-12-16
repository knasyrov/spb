class AddAttachmentToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :a_id, :string, :null => true
  end
end
