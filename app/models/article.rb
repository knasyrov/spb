# encoding: utf-8

class Article < ActiveRecord::Base
	belongs_to :writer, :foreign_key => "user_id"
	has_many :comments

	self.per_page = 10	
	default_scope order("created_at DESC")

	validates_length_of  :title, :minimum => 5, :message => 'Название должно содержать хотя бы 5 символов'
	validates_length_of  :body, :minimum => 20, :message => 'Содержимое должно содержать хотя бы 20 символов'
	validates_presence_of :user_id, :message => 'Пользователь должен быть писателем'	
end
