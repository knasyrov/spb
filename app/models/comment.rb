# encoding: utf-8
require 'digest/sha1'

class Comment < ActiveRecord::Base
	belongs_to :reader, :foreign_key => "user_id"
	belongs_to :article

	validates_presence_of :user_id, :message => 'Пользователь должны быть читателем'
	validates_presence_of :article_id
	validates_associated :article
	validates_length_of :body, :minimum => 5, :message => 'Комментарий должен содержать хотя бы 5 символов'	

	def a_link
		"http://localhost:9292/#{Digest::SHA1.hexdigest(a_id)}.tar.gz"
	end
end
