class CreateEnrolls < ActiveRecord::Migration
  def change
    create_table :enrolls do |t|
      t.references :projeto
      t.references :usuario

      t.timestamps
    end
    add_index :enrolls, :projeto_id
    add_index :enrolls, :usuario_id
  end
end
