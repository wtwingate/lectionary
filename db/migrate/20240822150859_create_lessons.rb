class CreateLessons < ActiveRecord::Migration[7.2]
  def change
    create_table :lessons do |t|
      t.string :references
      t.references :day, null: false, foreign_key: true

      t.timestamps
    end
  end
end
