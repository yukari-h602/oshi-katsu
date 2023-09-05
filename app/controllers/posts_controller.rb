class PostsController < ApplicationController
  before_action :find_post, only: %i[edit update destroy]

  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page]).per(6)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, success: t('defaults.message.created', item: Post.model_name.human)
    else
      flash.now['danger'] = t('defaults.message.not_created', item: Post.model_name.human)
      render :new
    end
  end

  def edit; end

	def update
		if @post.update(post_params)
			redirect_to posts_path, success: t('defaults.message.updated', item: Post.model_name.human)
		else
			flash.now['danger'] = t('defaults.message.not_updated', item: Post.model_name.human)
			render :edit
		end
	end

	def destroy
		@post.destroy!
		redirect_to posts_path, success: t('defaults.message.deleted', item: Post.model_name.human)
	end

  private

  def find_post
		@post = current_user.posts.find(params[:id])
	end

  def post_params
    params.require(:post).permit(:title, :twitter)
  end
end
