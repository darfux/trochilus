class RemoveAllEndowmentAttribute < ActiveRecord::Migration
  def up
    Project.transaction do
      Project.all.each do |p|
        p.endowment = false
        p.interest_rate = nil
        p.save!
      end
      DonationRecord::InterestPeriod.destroy_all
    end
  end
end
