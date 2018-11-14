class CreateQtexts < ActiveRecord::Migration[5.1]
  def change
    create_table :qtexts do |t|
      t.integer :parent_id
      t.string :text

      t.timestamps
    end
    add_index :qtexts, :parent_id
  end
end
