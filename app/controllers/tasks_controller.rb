class TasksController < ApplicationController
  def index
      @tasks = Task.all.order(created_at: "DESC")
  end

  def new
      @task = Task.new
  end
  
  def create
      @task = Task.new(task_params)
      if params[:back]
          render :new
      else
          if @task.save
              flash[:notice] = 'Taskの投稿に成功しました'
              redirect_to tasks_path
          else
              flash.now[:alert] = 'Taskの投稿に失敗しました'
              render :new
          end
      end
  end

  def show
      @task = Task.find(params[:id])
  end

  def edit
      @task = Task.find(params[:id])
  end
  
  def update
      @task = Task.find(params[:id])
      if @task.update(task_params)
          flash[:notice] = 'Taskを編集しました'
          redirect_to tasks_path
      else
          flash.now[:alert] = 'Taskの編集に失敗しました'
          render :edit
      end
  end
  
  def destroy
      @task = Task.find(params[:id])
      @task.destroy
      flash[:danger] = 'Taskを削除しました'
      redirect_to tasks_path
  end
  
  def confirm
      @task = Task.new(task_params)
      render :new if @task.invalid?
  end
  
  private
  
  def task_params
      params.require(:task).permit(:title,:content)
  end
end
