class AddRadiusToStar < ActiveRecord::Migration[7.0]
  def change
    add_column :stars, :radius, :integer
  end
end
