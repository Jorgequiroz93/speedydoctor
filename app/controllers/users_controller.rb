class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:doctors]

  def doctors
    @doctors = User.all.select { |user| user.role = "doctor" }
  end
end
