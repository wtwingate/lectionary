class CreateVerses < ActiveRecord::Migration[7.2]
  def change
    create_table :verses do |t|
      t.integer :number
      t.text :first_half
      t.text :second_half
      t.references :psalm, null: false, foreign_key: true

      t.timestamps
    end
  end
end
