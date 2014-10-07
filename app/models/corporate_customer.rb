class CorporateCustomer < ActiveRecord::Base
  include CommonCustomer
  acts_as_common_customer

  has_many :link_men, dependent: :destroy
  # has_many :ordinary_link_men, ->{ where('corporate_customer_link_men.corporate_customer_link_man_link_type_id' => 
  #   CorporateCustomer::LinkMan::LinkType.find_by(name: :ordinary).id) },
  #   class_name: :IndividualCustomer, through: :link_men, source: :individual_customer
  # has_many :manager_link_men, ->{ where('corporate_customer_link_men.corporate_customer_link_man_link_type_id' => 
  #   CorporateCustomer::LinkMan::LinkType.find_by(name: :manager).id) },
  #   class_name: :IndividualCustomer, through: :link_men, source: :individual_customer
  
  [:ordinary, :manager].each do |prefix|
    define_method("#{prefix}_link_men") do
      link_men.where(corporate_customer_link_man_link_type_id: CorporateCustomer::LinkMan::LinkType.send("#{prefix}_id"))
    end
  end

  def self.all_spy
    all.sort_by{ |e| e.name_with_py! }
  end
end
