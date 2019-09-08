class AddContextToContextNodes < ActiveRecord::Migration[5.1]
  def change
    add_column :context_nodes, :context, :string
  end
end
