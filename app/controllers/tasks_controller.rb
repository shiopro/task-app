class TasksController < ApplicationController

  def index
    @board = Board.find(params[:board_id])
    @tasks = @board.tasks
  end

  def new
    board = Board.find(params[:board_id])
    @task = board.tasks.build
  end

  def create
    board = Board.find(params[:board_id])
    @task = board.tasks.build(task_params)
    @task.user = current_user
    if @task.save
      redirect_to board_tasks_path(@task.board), notice: '保存できました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new, status: :unprocessable_entity
    end
  end
  
  private

  def task_params
    params.require(:task).permit(:title, :description, :end_date)
  end
end