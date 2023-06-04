class CreateMoons < ActiveRecord::Migration[7.0]
  def change
    create_table :moons do |t|
      t.string :name
      t.integer :radius
      t.references :planet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
