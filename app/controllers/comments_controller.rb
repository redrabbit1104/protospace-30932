class CommentsController < ApplicationController

  def create
    @comment = Comment.create(comment_params) 
    if @comment.save
    #  redirect_to "/prototypes/#{@comment.prototype.id}"
    redirect_to prototype_path(@comment.prototype_id)   #prototypeパスをPerfixで指定。(/prototypes/)commentモデルのprototype_idカラムの値を表示。(/prototypes/prototype_id値)

    else
     @prototype = @comment.prototype  #코멘트 하나에 연결된 프로트타입하나
     @comments = @prototype.comments  #프로트타입 하나에 연결된 코멘트들
     render "prototypes/show" #他のコントローラー（prototypes)のshowアクションをレンダーリング。
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, prototype_id: params[:prototype_id])
  end
end

