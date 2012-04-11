class Enroll < ActiveRecord::Base
  belongs_to :projeto
  belongs_to :usuario
  # attr_accessible :title, :body
end
