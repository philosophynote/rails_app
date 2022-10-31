class Service < ApplicationRecord
  has_many :authorities, through: :authority_service_relation
end
