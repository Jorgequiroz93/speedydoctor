class DoctorsController < ApplicationController

    def show
        @doctor = Doctor.find(params[:id])
        @doctor_avg_rating = @doctor.reviews.average(:rating)
        @consultation = Consultation.new()
      end
end
