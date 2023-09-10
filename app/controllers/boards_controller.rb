class BoardsController < ApplicationController
  skip_before_action :require_login, only: %i[index]
  before_action :set_board, only: %i[edit update destroy]

	def index
    boards = if(tag_name = params[:tag_name])
      Board.with_tag(tag_name)
    else
      Board.all
    end
    @q = boards.ransack(params[:q])
		@boards = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page]).per(6)
	end

  def new
    @board = Board.new
  end

  def create
    @board = current_user.boards.build(board_params)
    if @board.save
      @board.save_tags(tag_names: params.dig(:board, :tag_names).try(:split, ","))
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
      @board.save_tags(tag_names: params.dig(:board, :tag_names).try(:split, ","))
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
    @q = current_user.bookmark_boards.ransack(params[:q])
    @bookmark_boards = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page]).per(6)
  end

  def autocomplete
    @boards = Board.where('name LIKE ? OR title LIKE ? OR world LIKE ? OR charm LIKE ? OR body LIKE ?', "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%").limit(3)
    render layout: false
  end

  private

  def set_board
    @board = current_user.boards.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:name, :title, :world, :charm, :body)
  end
end
