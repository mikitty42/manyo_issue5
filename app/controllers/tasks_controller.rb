class TasksController < ApplicationController
    before_action :authenticate_user, only: [:index]

    def index
 
        if params[:sort_expired]
            @tasks = current_user.tasks.page(params[:page]).per(10).order(deadline: 'DESC')
        elsif  params[:sort_priority]
            @tasks = current_user.tasks.page(params[:page]).per(10).order('priority ASC')
        else
            @tasks = current_user.tasks.page(params[:page]).per(10).order(created_at: 'DESC')
        end

        
        if params[:task].present?
            if params[:task][:title].present? && params[:task][:status].present?
                @tasks = current_user.tasks.get_by_title(params[:task][:title]).get_by_status(params[:task][:status]).page(params[:page]).per(10)
            elsif params[:task][:title].present?
                @tasks = current_user.tasks.get_by_title(params[:task][:title]).page(params[:page]).per(10)
            elsif params[:task][:status].present?
                @tasks = current_user.tasks.get_by_status(params[:task][:status]).page(params[:page]).per(10)
            elsif params[:task][:label_id].present?
                @tasks = current_user.tasks.all.joins(:labels).where(labels: { id: params[:task][:label_id] }).page(params[:page]).per(10)
            end
        end
        
        


    end
        def new
            @task = Task.new
        end
        
        def create
            @task = current_user.tasks.build(task_params)
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
            @task = current_user.tasks.build(task_params)
            render :new if @task.invalid?
        end
        
        private
        
        def task_params
            params.require(:task).permit(:title,:content,:deadline,:status,:priority,{ label_ids: [] })
        end


end
