class CreateOptions < ActiveRecord::Migration[7.2]
  def change
    create_table :options do |t|
      t.references :poll, null: false, foreign_key: true
      t.string :text
      t.integer :votes

      t.timestamps
    end
  end
end
