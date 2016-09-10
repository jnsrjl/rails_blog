class MainPagesController < ApplicationController
  def home
    @main_pages = User.paginate(page: params[:page], per_page: 5)
  end

  def about
  end
end
