# encoding: utf-8
class IndividualCustomer < ActiveRecord::Base
  has_one :customer, as: :customer, dependent: :destroy, validate: true
  def self.ch
    "个人客户"
  end
end
