class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :name
      t.string :title
      t.string :session_id
      t.boolean :public

      t.timestamps
    end
  end
end
