class CommentsController < ApplicationController
  def index
    @comments = current_user.comments
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to comment_path(@comment), notice: "Created!"
    else
      render "new"
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    if @comment.update(params[:comment])
      redirect_to comment_path(@comment), notice: "Updated!"
    else
      render "edit"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      redirect_to comments_path, notice: "Removed!"
    else
      redirect_to comment_path(@comment), alert: "Try again!"
    end
  end


private
  def comment_params
    params.require(:comment)
      .permit(:value)
  end
end
