class UsersController < ApplicationController
    before_action :ensure_current_user, only: [:show]
    before_action :move_to_index, only: [:new]
    
    def index
        @users = User.all
    end
    
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notice] ='ユーザーの登録に成功しました'
            redirect_to user_path(@user.id)
        else
            render :new
        end
    end
    
    def show
        @user = User.find(params[:id])
        @tasks = current_user.tasks
    end
    
    def edit
        @user = User.find(params[:id])
    end
    
    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
          redirect_to user_path(@user.id), notice: "ユーザーを編集しました！"
        else
          render :edit
        end
      end
    
    
    private
    
    def user_params
        params.require(:user).permit(:name,:email,:password,:password_confirmation,:admin)
    end
    

    
    def ensure_current_user
        if current_user.id != params[:id].to_i
            flash[:notice] = '権限がありません'
            redirect_to tasks_path
        end
    end
    
    def move_to_index
        if logged_in?
            flash[:notice] = 'ログインしています'
        redirect_to tasks_path
        end
    end
end
