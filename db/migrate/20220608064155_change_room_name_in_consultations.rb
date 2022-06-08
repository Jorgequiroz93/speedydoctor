class ChangeRoomNameInConsultations < ActiveRecord::Migration[6.1]
  def change
    rename_column :consultations, :room_name, :room_url
  end
end
