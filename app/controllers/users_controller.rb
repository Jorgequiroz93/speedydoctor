class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:doctors]

  def doctors
    if params[:query].present?
      @doctors = User.where(role: "Doctor").search_globally(params[:query])
    else
      @doctors = User.where(role: "Doctor")
    end
  end
end
