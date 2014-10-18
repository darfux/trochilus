class DonationRecord::ActualFund < ActiveRecord::Base
  include CommonFundInstance
  acts_as_common_fund_instance

  belongs_to :donation_record
  belongs_to :fund_type

  has_one :proof, class_name: :Attachment, as: :attachment_owner, validate: true, dependent: :destroy
  # validates_presence_of :proof
  accepts_nested_attributes_for :proof, update_only: true

  def project
    donation_record.project
  end

  def record
    donation_record
  end

  def self.join_funds(opts={})
    joins(:fund).select('* ,funds.*')
  end 
end
