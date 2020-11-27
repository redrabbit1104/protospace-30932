class PrototypesController < ApplicationController
  # layout 'signup'
  before_action :authenticate_user!, except: [:index,:show]
  before_action :move_to_index, only: [:edit]   #editアクションの時にだけ、move_to_indexメソッドを実行

  def index
    @prototypes = Prototype.all
    # query = "SELECT * FROM prototypes"
    # @prototypes = Prototype.find_by_sql(query)


    # if user_signed_in?
    # @prototypes = Prototype.where(user_id: current_user.id) #Prototypeモデルでuser_idが現在ログイン中のidと一致する要素を取得し@prototypesに代入。
    # else
    # @prototypes = Prototype.all  #Prototypeモデルにあるテーブル全てのレコードを取得し@prototypes変数に代入。
    # end


  end

  def new
    @prototype = Prototype.new  #newアクションに@prototypeを定義し、Protypeモデルの新規投稿オブジェクトを代入。
  end

  # def create
  #   message = Prototype.create(prototype_params)
  #   if message.save
  #     redirect_to :action => index  #privateのrequire(:protype)を削除しないとエラーが出るので使わない。
  #   else
  #     render :new and return
  #   end
  # end

  def create
    @prototype = Prototype.create(prototype_params)
    if @prototype.save
      redirect_to index_path
    else
      render :new
    end
  end

  def show
    @prototype = Prototype.find(params[:id]) #クリックしたid値で、Prototypeモデルの特定のオブジェクトを取得する
    
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])  #もし、@prototypeではなくローカル変数prototypeにしてしまった場合、prototypeは一回しか保存されないため、renderにより呼び出された時に[:id]値が消えてしまう。
    if @prototype.update(prototype_params)    #つまりルートはhttp://localhost:3000/prototypes/8のルートが存在しなくなるため、エラーになる。よって何回も使い回せる@prototypeを使う。
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    if prototype.destroy            #この文が無いと画像が削除されない。
       redirect_to root_path
    end
  end

  def move_to_index         #indexページに戻すメソッドを定義
    @prototype = Prototype.find(params[:id])    #パラメーターから送信されたidに紐づいてるprototypeテーブルのレコードを取得し@prototypeに保存
    unless current_user.id == @prototype.user_id  #現在ログイン中のidとパラメーターから送信されたid(クリックした時に送信されたid値)が異なれば
      redirect_to action: :index   #インデックスページーを表示
    end
  end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end
end
