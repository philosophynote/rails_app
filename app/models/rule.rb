class Rule < ApplicationRecord
  has_many :authorities

  validates :rule_name, presence: true, length: { in: 1..30 }
end
