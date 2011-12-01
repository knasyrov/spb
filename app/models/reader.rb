class Reader < User
  #devise :database_authenticatable, :registerable, :trackable
  has_many :comments, :foreign_key => "user_id"
end