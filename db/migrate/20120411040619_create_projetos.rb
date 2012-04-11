class CreateProjetos < ActiveRecord::Migration
  def change
    create_table :projetos do |t|
      t.string :nome
      t.text :descricao
      t.references :usuario

      t.timestamps
    end
    add_index :projetos, :usuario_id
  end
end
