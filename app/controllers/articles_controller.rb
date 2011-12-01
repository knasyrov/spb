# encoding: utf-8

class ArticlesController < ApplicationController
  before_filter :authenticate_user!

  def index
    @articles = Article.page params[:page]

    respond_to do |format|
      format.html 
    end
  end

  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html 
    end
  end

  def new
    @article = Article.new

    respond_to do |format|
      format.html 
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(params[:article])
    (@article.writer = current_user) if (current_user.class == Writer)    

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Статья успешно сохранена' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update
    @article = Article.find(params[:id])
    (@article.writer = current_user) if (current_user.class == Writer)    

    respond_to do |format|
      if @article.update_attributes(params[:article])
        format.html { redirect_to @article, notice: 'Статья успешно обновлена' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
    end
  end
end
