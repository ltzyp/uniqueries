class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :sql_nodes, :class, :node_class
  end
end
