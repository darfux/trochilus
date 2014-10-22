class Date
  def month_before(date)
    (date.year * 12 + date.month) - (self.year * 12 + self.month)
  end
end