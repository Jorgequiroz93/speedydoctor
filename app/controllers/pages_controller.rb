class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :becomespeedy, :show ]

  def home
  end

  def becomespeedy
  end
end
