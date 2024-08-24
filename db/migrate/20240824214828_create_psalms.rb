class CreatePsalms < ActiveRecord::Migration[7.2]
  def change
    create_table :psalms do |t|
      t.integer :number
      t.string :title

      t.timestamps
    end
  end
end
