# encoding: utf-8

require 'sinatra/base'
require 'eventmachine'
require 'sinatra/async'

class Compressor < Sinatra::Base

  register Sinatra::Async

  aget '/dfd' do
  	#EM.system('ls'){ |output,status| puts output if status.exitstatus == 0 }
  	EventMachine::add_timer 10, proc { 
	  	puts "Executing timer event: #{Time.now}" 
	  	body 'ASYNC BODY'
	  }
  end

  get '/compress' do
  	cmd = "tar -czvf #{}.tar.gz /full/path"
  	EM.system('ls')
  end

  apost '/compress' do
    puts params.inspect
    EventMachine::add_timer 10, proc { 
      puts "Executing timer event: #{Time.now}" 
      body 'ASYNC BODY'
    }
  end  
end