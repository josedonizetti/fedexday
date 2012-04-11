class Projeto < ActiveRecord::Base
  belongs_to :usuario
  attr_accessible :descricao, :nome
  
  def enrolled? usuario
    enroll = Enroll.where("usuario_id = ? and projeto_id = ?", usuario.id, self.id).first
    enroll.nil?
  end
end
