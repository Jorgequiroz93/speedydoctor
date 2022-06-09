class DoctorsController < ApplicationController

    def show
        @doctors = User.where(role: "Doctor")
        @doctor = @doctors.find(params[:id])
        #@doctor_avg_rating = @doctor.reviews.average(:rating)
        @consultation = Consultation.new()
    end

end
