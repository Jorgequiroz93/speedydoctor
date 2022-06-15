class DoctorsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @doctors = User.where(role: "Doctor")
    @doctor = @doctors.find(params[:id])
    # @doctor_avg_rating = @doctor.reviews.average(:rating)
    @consultation = Consultation.new
  end

  def change_status_to_available
    @doctor = current_user
    @doctor.status = " Available"
    if @doctor.save
      redirect_to dashboard_path
    else
      render :new
    end
  end

  def change_status_to_off
    @doctor = current_user
    @doctor.status = " Offline"
    if @doctor.save
      redirect_to dashboard_path
    else
      render :new
    end
  end
end
