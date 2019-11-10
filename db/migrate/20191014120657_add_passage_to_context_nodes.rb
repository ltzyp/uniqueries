class AddPassageToContextNodes < ActiveRecord::Migration[5.1]
  def change
    add_column :context_nodes, :passage, :number
  end
end
