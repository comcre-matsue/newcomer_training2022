class AddPictureToMicroposts < ActiveRecord::Migration[7.0]
  def change
    add_column :microposts, :picture, :string
  end
end
