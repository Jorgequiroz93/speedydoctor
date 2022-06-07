class AddRatingsToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :speed_rating, :float
    add_column :reviews, :gentleness_rating, :float
    add_column :reviews, :professionalism_rating, :float
    add_column :reviews, :clarity_rating, :float
  end
end
