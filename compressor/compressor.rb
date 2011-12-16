# encoding: utf-8

require 'sinatra/base'
require 'eventmachine'
#require 'sinatra/async'
require 'fileutils'
require 'digest/sha1'

class Compressor < Sinatra::Base
  use Rack::Static, :urls => ["/files"], :root => File.join(File.dirname(__FILE__), "/public")

  post '/comments' do
    name = Time.now.to_i.to_s
    Dir.mkdir(File.dirname(__FILE__) + "/public/#{name}")
    files = []
    params[:attachment].each do |k,v|
      File.rename(v[:tempfile].path, "./public/#{name}/#{v[:filename]}") 
      files << v[:filename]
    end
    cmd = "tar -czvf public/#{Digest::SHA1.hexdigest(name)}.tar.gz -C #{File.dirname(__FILE__) + "/public/#{name}"} #{files.join(' ')}"
    puts cmd
    EM.system(cmd) do |output,status| 
      #puts output if status.exitstatus == 0 
      FileUtils.rm_rf(File.dirname(__FILE__) + "/public/#{name}")
    end
    puts "RETURN #{name}"
    name
  end
end
