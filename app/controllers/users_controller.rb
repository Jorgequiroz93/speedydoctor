class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:doctors]
  before_action :authenticate_user!, only: :toggle_favorite

  def doctors
    if params[:query].present?
      @doctors = User.where(role: "Doctor").search_globally(params[:query])
    else
      @doctors = User.where(role: "Doctor")
    end
    # getting consultations from users when they are doctors
    @doctor_consultations = User.joins(:consultation).where(doctor_id: @doctors)
    # get consultations where rating is 5
    @five_rating = Consultation.joins(:review).where(review: { rating: 5 })

    @hdoctors = @doctors.sort_by { |doctor| doctor.reviews.sum(:rating) }.first(5)
    # connect doctors to consultations with 5 star rating through reviews
    # @recommended_doctors = @five_rating.
    # @recommended_doctors = @doctors.joins(:consultation).joins(:review).where(rating: 5).first(5)
  end

  def toggle_favorite
    @user = User.find_by(id: params[:id])
    user_signed_in? && current_user.favorited?(@user) ? current_user.unfavorite(@user) : current_user.favorite(@user)
  end
end
