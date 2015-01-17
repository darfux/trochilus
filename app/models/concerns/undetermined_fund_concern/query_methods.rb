module UndeterminedFundConcern
  module QueryMethods
    extend ActiveSupport::Concern
    included do
      scope :with_fund, ->(opts={}){
        condition = {}
        if t=opts[:time]
          condition = {funds: {time: t}}
        end
        joins(outerjoin_arg(:fund, :fund_instance, condition)).select('* ,funds.*')
      }
    end
  end
end