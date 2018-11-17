class ChangeQtextToSintaxtree < ActiveRecord::Migration[5.1]
  def change
    rename_table :qtexts, :syntaxtrees
  end
end
