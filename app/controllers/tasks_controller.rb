class TasksController < ApplicationController
  before_action :set_task, only: [:index, :show, :edit, :update]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @tasks = @board.tasks
    @tasks = Task.includes(comments: :user).all
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

  def show
    @task = Task.find(params[:id])
    @comments = @task.comments
  end
  
  def edit
    @task = @board.tasks.find(params[:id])
  end

  def update
    @task = @board.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to board_task_path(@board, @task), notice: '更新できました'
    else
      flash.now[:error] = '更新できませんでした'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    board = Board.find(params[:board_id])
    task = board.tasks.find(params[:id])
    task.destroy!
    redirect_to board_tasks_path(board), notice: '削除に成功しました'
  end

  private

  def task_params
    params.require(:task).permit(:title, :description, :end_date, :eyecatch)
  end

  def set_task
    @board = Board.find(params[:board_id])
  end
end