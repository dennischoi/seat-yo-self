class ReviewsController < ApplicationController
  before_action :ensure_logged_in, only: %i(create destroy)
  before_action :load_restaurant

  def show
    @review = Review.find(params[:id])
  end

  def create
    @review = @restaurant.reviews.build(review_params)
    @review.user = current_user
    if @review.save
      redirect_to restaurants_url, notice: 'Review added!'
    else
      flash.now[:alert] = "ERRPRPR"
      render 'restaurants/show'
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
  end

  private
  def review_params
    params.require(:review).permit(:comment, :restaurant_id)
  end

  def load_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

end
