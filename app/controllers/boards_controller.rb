class BoardsController < ApplicationController
  skip_before_action :require_login, only: %i[index]
	def index
		@boards = Board.all.includes(:user).order(created_at: :desc)
	end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      redirect_to boards_path, success: t('defaults.message.created', item: Board.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_created', item: Board.model_name.human)
      render :new
    end
  end

  def show
    @board = Board.find(params[:id])
  end

  private

  def board_params
    params.require(:board).permit(:name, :title, :world, :charm, :body)
  end
end
