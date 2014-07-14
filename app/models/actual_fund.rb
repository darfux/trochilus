class ActualFund < Fund
  validates_presence_of :fund_type_id, :message => "不能为空"
end