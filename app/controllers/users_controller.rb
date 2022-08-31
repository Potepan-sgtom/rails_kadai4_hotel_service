class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ユーザー登録が完了しました"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "ユーザー情報を更新しました"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  #三回目提出時変更箇所(DBへ接続できておらずユーザー情報の表示が変わらなかったためfind_by(の後に:idを挿入し改善)↓
  def show
　  @user = User.find_by(id: params[:id])
　end

  private

    def user_params
      params.require(:user).permit(:name, :email, :introduction, :password, :password_confirmation, :image)
    end
  end
end
