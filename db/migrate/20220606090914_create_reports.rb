class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.references :consultation, null: false, foreign_key: true
      t.text :content
      t.text :prescription

      t.timestamps
    end
  end
end
