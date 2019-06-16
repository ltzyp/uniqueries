class CreateSqlNodes < ActiveRecord::Migration[5.1]
  def change
    create_table :sql_nodes do |t|
      t.references :sql_tree, foreign_key: true
      t.belongs_to :parent, foreign_key: true
      t.string :class
      t.string :value
      t.string :notes

      t.timestamps
    end
  end
end
