class CommentsController < ApplicationController
  before_action :require_sign_in
  before_action :authorize_user, only: [:destroy]

  def create
    if params[:post_id]
       parent = Post.find(params[:post_id])
    else
       parent = Topic.find(params[:topic_id])
    end

    comment = Comment.new(comment_params)
    comment.user = current_user
    parent.comments << comment

    if comment.save
      flash[:notice] = "Comment saved successfully"
    else
      flash[:alert] = "Comment failed to save."
    end

    if params[:post_id]
      redirect_to [parent.topic, parent]
    else
      redirect_to parent
    end

  end

  def destroy
    if params[:post_id]
       parent = Post.find(params[:post_id])
    else
       parent = Topic.find(params[:topic_id])
    end

    comment = parent.comments.find(params[:id])


    if comment.destroy
      flash[:notice] = "Comment deleted successfully"
    else
      flash[:alert] = "Comment failed to delete."
    end

    if params[:post_id]
      redirect_to [parent.topic, parent]
    else
      redirect_to parent
    end

  end

#  def destroy
#    @post = Post.find(params[:post_id])
#    comment = @post.comments.find(params[:id])

#    @topic = Topic.find(params[:topic_id])
#    comment = @topic.comments.find(params[:id])

#    if comment.destroy
#      flash[:notice] = "Comment was deleted"
#      redirect_to [@post.topic, @post]
#    else
#      flash[:alert] = "Comment could'nt be deleted. Try again."
#      redirect_to [@post.topic, @post]
#    end
#  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorize_user
    comment = Comment.find(params[:id])
    unless current_user == comment.user || current_user.admin?
      flash[:alert] = "You do not have permission to delete a comment."
      redirect_to [comment.post.topic, comment.post]
    end
  end

end
