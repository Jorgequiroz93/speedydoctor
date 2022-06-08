class AddCallRoomNameToConsultations < ActiveRecord::Migration[6.1]
  def change
    add_column :consultations, :room_name, :string
  end
end
