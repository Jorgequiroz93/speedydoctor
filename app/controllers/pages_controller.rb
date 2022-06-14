class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :becomespeedy, :styleguide]

  def home
  end

  def becomespeedy
  end

  def styleguide
    @doctors = User.where(role: "Doctor")
    @recommended_doctors = @doctors.reviews.where(rating: 5).first(5)
  end

  def dashboard
    @doctors = User.where(role: "Doctor")
    @my_consultations = Consultation.where(patient: current_user)
  end
end
