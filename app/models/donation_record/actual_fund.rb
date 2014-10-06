class DonationRecord::ActualFund < ActiveRecord::Base
  include CommonFundInstance
  acts_as_common_fund_instance

  belongs_to :donation_record
  belongs_to :fund_type

  has_one :proof, class_name: :Attachment, as: :attachment_owner, validate: true, dependent: :destroy
  validates_presence_of :proof
  accepts_nested_attributes_for :proof, update_only: true
  after_initialize :set_default_proof

  def set_default_proof
    build_proof unless self.proof
  end

  #If using with the :through option, the association on the join model must be a belongs_to, 
  #and the records which get deleted are the join records, rather than the associated records.
  # has_one :fund, as: :fund_instance, dependent: :destroy, validate: true
end
