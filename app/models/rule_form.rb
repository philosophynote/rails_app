class RuleForm
 include ActiveModel::Model
 include ActiveModel::Attributes
 
#  attribute :rule_name, :string
#  attribute :
  # attr_accessor :rule_name
  # attr_accessor :write
  # attr_accessor :read
  # attr_accessor :write_services
  # attr_accessor :read_services
  attribute :rule_name
  attribute :write
  attribute :read
  attribute :write_services
  attribute :read_services
 
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
    read_authority = rule.authorities.build(authority: Authority.authorities[:read] )
    read_services = self.attributes["read"]["service_ids"].compact_blank
    if read_services&.any?
      read_services.each do |read_service|
        read_authority.authority_service_relations.build(service_id: read_service)
      end
    end
    
    write_authority = rule.authorities.build(authority: Authority.authorities[:write])
    write_services = self.attributes["write"]["service_ids"].compact_blank
    if write_services&.any?
      write_services.each do |write_service|
        write_authority.authority_service_relations.build(service_id: write_service)
      end
    end
    binding.pry
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
    # binding.pry
    {
      rule_name: rule.rule_name,
      read: rule.authorities.read,
      write: rule.authorities.write,
      read_services: rule.authorities.read.joins(:services),
      write_services: rule.authorities.write.joins(:services),
      # read_service_ids: rule.authorities.joins(:services).where(authority: Authority.authorities[:read]).pluck(:service_id),
      # write_service_ids: rule.authorities.joins(:services).where(authority: Authority.authorities[:write]).pluck(:service_id)
    }
  end
end
  
  