class CreatePassages < ActiveRecord::Migration[7.2]
  def change
    create_table :passages do |t|
      t.string :reference
      t.text :esv_text
      t.text :esv_html
      t.references :lesson, null: false, foreign_key: true

      t.timestamps
    end
  end
end
