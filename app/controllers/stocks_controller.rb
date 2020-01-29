class StocksController < ApplicationController
  
  def search
    if params[:stock].present?
      @stock = Stock.new_lookup(params[:stock])
      if @stock
        respond_to do |format|
          format.js { render partial: 'users/result'}
        end
      else
        flash.now[:alert] = "Invalid symbol search"
        render "users/my_portfolio"
      end
    else
      flash[:alert] = "Invalid symbol search"
      redirect_to my_portfolio_path
    end
  end
end
