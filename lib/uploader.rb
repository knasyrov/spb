# encoding: utf-8
#require(File.dirname(__FILE__) + "/../config/environment") unless defined?(Rails)

require 'rack/request'
require "net/http"

class Uploader
	def initialize(app)  
    @app = app  
  end  

  def call(env)  
    request = Rack::Request.new(env)
 
    if (request.post? && request.path_info =~ /^\/comments/)
      req = Net::HTTP::Post.new(request.path_info)
      req.body_stream = request.body
      req.content_type = request.content_type
      req.content_length = request.content_length

      res = Net::HTTP.new('localhost', 9292).start {|http| http.request(req) }

      case res
      when Net::HTTPSuccess, Net::HTTPRedirection
        request.POST['a_id'] = res.body
        puts "UPLOAD RESULT = #{res.body}"

        request.params.each do |k,v|
          if k == 'attachment'
            v.each do |id, f|
               f[:tempfile].close! rescue nil
            end
            request.POST.delete k
            request.GET.delete k
          end
        end
      else
        res.error!
      end
   
    end
    @app.call(env)  
  end

end