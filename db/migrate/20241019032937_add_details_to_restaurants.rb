class AddDetailsToRestaurants < ActiveRecord::Migration[6.1]
  def change
    add_column :restaurants, :slogan, :string
    add_column :restaurants, :logo, :string
    add_column :restaurants, :country, :string
    add_column :restaurants, :latitude, :float
    add_column :restaurants, :longitude, :float
  end
end
