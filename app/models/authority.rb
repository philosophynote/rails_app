class Authority < ApplicationRecord
  belongs_to :rule
  has_many :services, through: :authority_service_relation
end
