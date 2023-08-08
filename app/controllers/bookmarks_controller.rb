class BookmarksController < ApplicationController
  def create
    board = Board.find(params[:board_id])
    current_user.bookmark(board)
    redirect_to request.referer || root_path, success: t('.success')
  end

  def destroy
    board = current_user.bookmarks.find(params[:id]).board
    current_user.unbookmark(board)
    redirect_to request.referer || root_path, success: t('.success')
  end
end
