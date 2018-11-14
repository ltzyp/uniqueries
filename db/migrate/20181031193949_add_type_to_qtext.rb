class AddTypeToQtext < ActiveRecord::Migration[5.1]
  def change
    add_column :qtexts, :type, :string
  end
end
