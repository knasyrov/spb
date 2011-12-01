# encoding: utf-8

class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @comment = Comment.new(params[:comment])
    (@comment.reader = current_user) if (current_user.class == Reader)
    @article = @comment.article

    respond_to do |format|
      if @comment.save
        format.js { render :action => :show }
      else
        #format.js { }
      end
    end
  end

  def show
  end

end
