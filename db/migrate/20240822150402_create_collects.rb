class CreateCollects < ActiveRecord::Migration[7.2]
  def change
    create_table :collects do |t|
      t.text :text
      t.references :day, null: false, foreign_key: true

      t.timestamps
    end
  end
end
