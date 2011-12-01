# encoding: utf-8

class CommentsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @comment = Comment.new(params[:comment])
    (@comment.reader = current_user) if (current_user.class == Reader)
    @article = @comment.article

    respond_to do |format|
      if @comment.save
        logger.info 'dfdf'
        format.js { render :action => :show }
      else
        logger.info 'dfddfsdafsdafsadfdsfds'
        #format.json { render :json => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
  end

end
