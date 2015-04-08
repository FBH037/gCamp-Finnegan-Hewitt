class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    @comment.task_id = params[:task_id]
    if @comment.save
      redirect_to project_task_path(params[:project_id], params[:task_id]), notice: "Comment was successfully created"
    else
      redirect_to project_task_path(params[:project_id], params[:task_id])
    end
  end

private

  def comment_params
    params.require(:comment).permit(:description)
  end

end
