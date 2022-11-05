class Authority < ApplicationRecord
  belongs_to :rule
  has_many :authority_service_relations
  has_many :services, through: :authority_service_relations
  enum authority: { read: 1, write: 2 }
end
