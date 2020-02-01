class UsersController < ApplicationController
  def my_portfolio
    @tracked_friends = current_user.friends
  end

  def my_friends
    @friends = current_user.friends
  end

  def search
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends = current_user.except_current_user(@friends)
      if @friends.length > 0
        respond_to do |format|
          format.js { render partial: "users/friend-result" }
        end
      else
        respond_to do |format|
          flash.now[:notice] = "Nobody found !"
          format.js { render partial: "users/friend-result" }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter something to search"
        format.js { render partial: "users/friend-result" }
      end
    end
  end
end
