# encoding: utf-8

class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @comment = Comment.new
    @comment.article_id = params[:comment][:article_id]
    @comment.body = params[:comment][:body]
    @comment.a_id = params[:a_id] if params[:a_id]
    (@comment.reader = current_user) if (current_user.class == Reader)
    @article = @comment.article

    if @comment.save
      if params[:a_id]
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
