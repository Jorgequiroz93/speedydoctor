class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:doctors]

  def doctors
    if params[:query].present?
      @doctors = User.all.where("specialty ILIKE ?", "%#{params[:query]}%")
    else
      @doctors = User.all.select { |user| user.role = "doctor" }
    end
  end
end
