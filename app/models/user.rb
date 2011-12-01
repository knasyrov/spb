# encoding: utf-8

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :trackable

  attr_accessible :email, :password, :password_confirmation, :login, :type
  validates_presence_of :login
  validates_presence_of :type
end



