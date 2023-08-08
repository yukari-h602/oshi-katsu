class BoardsController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  before_action :set_board, only: %i[edit update destroy]

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
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @board = Board.find(params[:id])
    @comment = Comment.new
    @comments = @board.comments.includes(:user).order(created_at: :desc)
  end

  def edit; end

  def update
    if @board.update(board_params)
      redirect_to @board, success: t('defaults.message.updated', item: Board.model_name.human)
    else
      flash.now[:danger] = t('defaults.message.not_updated', item: Board.model_name.human)
      render :edit
    end
  end

  def destroy
    @board.destroy!

    redirect_to boards_path, success: t('defaults.message.deleted', item: Board.model_name.human)
  end

  def bookmarks
    @bookmark_boards = current_user.like_boards.includes(:user).order(created_at: :desc)
  end

  private

  def set_board
    @board = current_user.boards.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:name, :title, :world, :charm, :body)
  end
end
