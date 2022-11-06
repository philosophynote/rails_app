class RuleForm
 include ActiveModel::Model
 include ActiveModel::Attributes
 
  attribute :rule_name, :string
  attribute :read
  attribute :write
 
 validates :rule_name, presence: true, length: { in: 1..30 }
 
 delegate :persisted?, to: :rule
 
 def initialize(attributes = nil, rule: Rule.new)
  @rule = rule
  attributes ||= default_attributes
  super(attributes)
 end
 
 def save
  return if invalid?

  ActiveRecord::Base.transaction do  


    rule.authorities.destroy_all
    if read[:services]&.any?
      read_authority = rule.authorities.build(authority: Authority.authorities[:read] )
      read[:services].compact_blank!
      read[:services].each do |read_service|
        read_authority.authority_service_relations.build(service_id: read_service)
      end
    end
    
    if write[:services]&.any?
      write_authority = rule.authorities.build(authority: Authority.authorities[:write])
      write[:services].compact_blank!
      write[:services].each do |write_service|
        write_authority.authority_service_relations.build(service_id: write_service)
      end
    end
    rule.update!(rule_name: rule_name)
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
        read: { services: rule.authorities.read.joins(:services) },
        write: { services: rule.authorities.write.joins(:services) },
      }
    end
end
  
  