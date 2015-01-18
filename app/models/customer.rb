class Customer < ActiveRecord::Base
  include PolymorphicExtension
  include CustomerConcern::QueryMethods
  has_pin_yin_name
  belongs_to :customer, polymorphic: true
  # has_and_belongs_to_many :customer_groups
  belongs_to :creator, class_name: :User

  belongs_to :region_country, class_name: 'Region::Country'
  belongs_to :region_state, class_name: 'Region::State'
  belongs_to :region_city, class_name: 'Region::City'
  alias_attribute :country, :region_country
  alias_attribute :state, :region_state
  alias_attribute :city, :region_city
  alias_attribute :country_id, :region_country_id
  alias_attribute :state_id, :region_state_id
  alias_attribute :city_id, :region_city_id
  

  has_many :donation_records
  has_many :item_donation_records
  has_many :contact_records

  has_many :project_link_men
  has_many :link_projects, class_name: :Project, through: :project_link_men, source: :project

  has_many :customer_group_customers
  has_many :customer_groups, through: :customer_group_customers

  validates_presence_of :name
  
  set_accessable_attributes [
    :total_donation, :contact_records, :donation_records, :item_donation_records,
    :link_projects, :creator, :customer_groups, :name_with_py, :country, :state, :city
  ]

  filter_where_keys [:customer_type, {name: {op: :like, split: true}}]
  filter_virtual_columns [:donation_amount]
  filter_scoped_orders [:donation_amount]

  def customer_type
    super
  end

  def total_donation
    amount = 0
    self.donation_records.each do |r|
      amount+=r.plan_fund.amount
    end
    amount
  end

  def to_s
    name
  end
end
