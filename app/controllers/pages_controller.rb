class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :becomespeedy, :styleguide]

  def home
  end

  def becomespeedy
  end

  def styleguide
  end
end
