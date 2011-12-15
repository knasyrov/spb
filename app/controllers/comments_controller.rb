# encoding: utf-8

class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @comment = Comment.new
    @comment.article_id = params[:comment][:article_id]
    @comment.body = params[:comment][:body]
    (@comment.reader = current_user) if (current_user.class == Reader)
    @article = @comment.article

    if @comment.save
      if params[:attachment]
        files = []
        params[:attachment].each_value do |a|
          puts "!!!!!! #{a.inspect}"
          #files << a.path
        end
        http = EventMachine::HttpRequest.new('http://localhost:9292/compress').post :body => request.POST
        http.callback { |chunk| puts "Upload finished!" }          
        puts "@@ #{request.raw_post()}"

        redirect_to @article, :notice => 'Файлы будут загружены на сервер в фоновом режиме'
      else
        render :json => @comment
      end
    else
      if params[:attachment]
        redirect_to @article, :error => 'Ошибки комментирования'
      else
        render :json => @comment.errors, :status => :unprocessable_entity
      end
    end      

  end

  def show
  end

end
