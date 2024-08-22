class CreateDays < ActiveRecord::Migration[7.2]
  def change
    create_table :days do |t|
      t.string :name
      t.string :service
      t.string :year
      t.string :season
      t.string :color
      t.integer :rank

      t.timestamps
    end
  end
end
