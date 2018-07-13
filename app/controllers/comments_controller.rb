class CommentsController < ApplicationController
  before_action :require_user
  
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @comment = @recipe.comments.build(comment_params)
    @comment.chef = current_chef
    if @comment.save
      ActionCable.server.broadcast "comments", render(partial: 'comments/comment', object: @comment)
      #flash[:success] = "Comment was created sucessfully" #Needs to be greyed out for actioncable to effecticely work
      #redirect_to recipe_path(@recipe)
    else
      flash[:danger] = "Comment wasn't created"
      redirect_to :back
    end
    
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:description)
  end
  
end