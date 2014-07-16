class ActualFund < Fund
  has_one :donation_record_actual_fund, foreign_key: :fund_id
  has_one :donation_record, through: :donation_record_actual_fund
  validates_presence_of :fund_type_id, :message => "不能为空"
end