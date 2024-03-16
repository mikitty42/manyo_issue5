class Admin::UsersController < ApplicationController
    before_action :admin_user

    
    def index
        @users = User.all.order('created_at DESC')
    end
    
    def new
        @user = User.new
    end
    
    def create
        @user = User.new(user_params)
        if @user.save
            flash[:notice] = 'ユーザーの登録に成功しました'
            redirect_to admin_users_path
        else
            render :new
        end
    end
    
    def edit
        @user = User.find(params[:id])
    end
    
    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
          flash[:notice] = 'ユーザーの編集に成功しました'
          redirect_to roots_path
        else
          render :edit
        end
      end
    
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        flash[:notice] = 'ユーザーを削除しました'
        redirect_to admin_users_path
    end
    
    private
    
    
    
    def admin_user
        unless current_user.admin?
          flash[:notice] = '管理者以外はアクセス出来ません'
          redirect_to(root_path)
        end
    end
    
    def user_params
        params.require(:user).permit(:name,:email,:password,:password_confirmation,:admin)
    end
end
