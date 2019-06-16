class CreateSqlTrees < ActiveRecord::Migration[5.1]
  def change
    create_table :sql_trees do |t|
      t.string :text

      t.timestamps
    end
  end
end
