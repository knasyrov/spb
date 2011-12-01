class Writer < User
  #devise :database_authenticatable, :registerable, :trackable
  has_many :articles, :foreign_key => "user_id"
end