class DonationRecord::ActualFund < ActiveRecord::Base
  include CommonFundInstance
  acts_as_common_fund_instance

  belongs_to :donation_record
  belongs_to :fund_type

  has_one :proof, class_name: :Attachment, as: :attachment_owner, validate: true, dependent: :destroy
  # validates_presence_of :proof
  accepts_nested_attributes_for :proof, update_only: true

  scope :with_fund, ->(opts={}){ 
    condition = {}
    if t=opts[:time]
      condition = {funds: {time: t}}
    end
    joins(outerjoin_arg(:fund, :fund_instance, condition)).select('* ,funds.*') 
  }

  def project
    donation_record.project
  end

  def record
    donation_record
  end

end
