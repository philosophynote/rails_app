class AuthorityServiceRelation < ApplicationRecord
  belongs_to :authority
  belongs_to :service
end
