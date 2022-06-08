class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:doctors]

  def doctors
    if params[:query].present?
      @doctors = User.all.search_by_first_name_and_last_name_and_specialty_and_country_and_language(params[:query])
    else
      @doctors = User.all.select { |user| user.role = "doctor" }
    end
  end
end
