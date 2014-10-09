class Currency < ActiveRecord::Base
  has_many :funds

  def self.all_ssym
    all.order(:symbol)
  end

  def self.CNY
    @CNY ||= find_by!(symbol: :CNY)
  end
end
