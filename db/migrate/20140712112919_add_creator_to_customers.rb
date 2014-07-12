class AddCreatorToCustomers < ActiveRecord::Migration
  def change
    add_reference :customers, :creator, index: true
  end
end
