class CorrectFundCurrency < ActiveRecord::Migration
  def up
    ActiveRecord::Base.transaction do
      Currency.all.each do |c|
        c.id -= 1; c.save!
      end
      Fund.where('currency_id > 1').each do |f|
        f.currency_id -=1; f.save!
      end
    end
  end
end
