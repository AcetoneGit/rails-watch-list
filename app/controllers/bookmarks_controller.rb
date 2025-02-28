class BookmarksController < ApplicationController
  # before_action :set_list, only: [:new, :create]

    def index
      @bookmarks = Bookmark.all
    end

    def new
      @bookmark = Bookmark.new
      @list = List.find(params[:list_id])
    end

    def create
      @list = List.find(params[:list_id])
      @bookmark = Bookmark.new(bookmark_params)
      @bookmark.list_id = @list.id
      # @list.bookmark_id = @bookmark.id
      @bookmark.save
      redirect_to list_path(params[:list_id])
    end

    def destroy
      @bookmark = Bookmark.find(params[:id])
      list = @bookmark.list
      @bookmark.destroy
      redirect_to list_path(list), status: :see_other
    end

    private

    def set_list
      @list = List.find(params[:id])
    end

    def bookmark_params
      params.require(:bookmark).permit(:comment, :movie_id)
    end
end
