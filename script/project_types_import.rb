str =<<types
助学金
奖助学金
奖教金
学科建设基金 
学生国际交流 
学生科创
学生就业
学生活动
教师国际交流
特聘教授 
校园文化 
学校发展基金 
校长基金
社会公益基金 
其他
大病救助金
types

str.each_line do |t|
  pt = ProjectType.new({name: t})
  pt.save
end