class Currency < ActiveRecord::Base
  has_many :funds

  def self.all_ssym
    all.order(:symbol)
  end

  def self.CNY
    find_by_symbol(:CNY)
  end
end
