class ChangeSqlNodeToContextNode < ActiveRecord::Migration[5.1]
  def change
    rename_table :sql_trees, :context_trees
    rename_table :sql_nodes, :context_nodes
    rename_column :context_nodes, :sql_tree_id, :context_tree_id
  end
end
