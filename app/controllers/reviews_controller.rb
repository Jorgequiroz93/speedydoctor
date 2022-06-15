class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @review.consultation_id = params[:id]
    @review.rating = ((params[:review][:speed_rating].to_i + params[:review][:gentleness_rating].to_i + params[:review][:professionalism_rating].to_i + params[:review][:clarity_rating].to_i)/4).round(1)
    # raise
    if @review.save!
      redirect_to "/dashboard"
    else
      flash[:alert] = "Something went wrong."
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :speed_rating, :gentleness_rating, :professionalism_rating, :clarity_rating)
  end
end
