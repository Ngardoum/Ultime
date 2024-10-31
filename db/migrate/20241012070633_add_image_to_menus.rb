class AddImageToMenus < ActiveRecord::Migration[6.1]
  def change
    add_column :menus, :image, :string
  end
end
