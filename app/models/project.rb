class Project < ActiveRecord::Base
  audited except: [:name_abbrpy, :creator_id]
  has_pin_yin_name
  belongs_to :project_level
  belongs_to :project_state
  belongs_to :project_type
  belongs_to :creator, class_name: :User, foreign_key: :creator_id
  belongs_to :create_unit, class_name: :UnivUnit, foreign_key: :create_unit_id
  belongs_to :create_manager, class_name:  :UnivUnitManager, foreign_key: :create_manager_id

  has_many :project_link_men, dependent: :destroy
  has_many :link_men, class_name: :Customer, through: :project_link_men, source: :customer
  has_many :donation_records, dependent: :destroy
  has_many :usage_records, dependent: :destroy
  has_many :news, dependent: :destroy

  has_many :attachments, as: :attachment_owner, validate: true, dependent: :destroy
  
  validates_associated :link_men
  validates_associated :project_link_men

  validates_presence_of :project_level
  validates_presence_of_all except: [:interest_rate, :endowment, :brief, :serialnum, :create_manager, :comment]
  
  def endowment_t
    e = endowment ? :eyes : :eno
    I18n.translate(e, scope: 'project.endowment')
  end
  
  def self.attribute_show(key, value)
    attribute = foreign_keys[key.to_sym]
    return value unless attribute
    Project.new(key => value).send(attribute).name
  end

  [:total_amount, :actual_amount, :interest_amount].each do |method_name|      
    define_method(method_name, 
      ->(opts = {}, *splat, &block) do
        amount = 0
        donation_records.each do |r|
          amount+=r.send(method_name, opts)
        end
        amount
      end
    )
  end
  alias_method :principle_amount, :total_amount


  [:principle_used, :interest_used].each do |method_name|
    type = method_name.to_s.split('_')[0]
    type_id = FundType.where(name: type).take
    define_method(method_name,
     ->(opts = {}, *splat, &block) do                
        amount = 0                                
        usage_records.each do |r|
          amount += r.send(method_name, opts)
        end
        amount
      end
    )
  end

  [:principle_rest, :interest_rest].each do |method_name|
    type = method_name.to_s.split('_')[0]
    define_method(method_name,
     ->(opts = {}, *splat, &block) do                
        self.send("#{type}_amount") - self.send("#{type}_used")
      end
    )
  end

end