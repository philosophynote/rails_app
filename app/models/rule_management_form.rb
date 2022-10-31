class RuleManagementForm
 include ActiveModel::Model
 include ActiveModel::Attributes
 
 attribute :rule_name, :string
 attribute :authority_name
 attribute :survice_ids
 
 validates :rule_name, presence: true, length: { in: 1..30 }
 validates :authority_name, presence: true, length: { maximum: 50 }
 
 delegate :persisted?, to: :rule
#  @form = RuleManagementForm.new
 # @from.rule.persisted?が@from.persisted?で書けるようになる
 delegate :persisted?, to: :policy
 
 def initialize(attributes = nil, rule: Rule.new)
  @rule = rule
  # @authority = authority
  attributes ||= default_attributes
  super(attributes)
 end
 
 def save
  return if invalid?

  ActiveRecord::Base.transaction do
      rule.update!(rule_name: rule_name, survice_ids: survice_ids)
    end
  rescue ActiveRecord::RecordInvalid
    false
 end
 
 def to_model
  rule
 end
 
 private

  attr_reader :rule
  
  def default_attributes
    {
      rule_name: rule.rule_name,
      authority_name: rule.authorities.pluck(:authority_name),
      survice_ids: rule.authorities.joins(:survices).pluck(:survice_id)
    }
  end
end
  
  