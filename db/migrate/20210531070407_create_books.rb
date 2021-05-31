class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.string :author, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
