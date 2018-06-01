require "pry"
def assert(cond)
	raise "assert fail" unless cond
end

@arr = []

def p(obj)
	@arr << "\"#{obj}\""
end

counter = 0

@all = []


begin
Fund.select_by_type(Fund.poly_types.actual_out).manage_view.
	# order('time ASC').
	# where("time >= ?", Date.new(,,)).
	each do |f|

	@arr = []


	@fund = f

	p f["project_name"]
	time = f["time"]
	date = I18n.localize(time)
	p date.split[0]
	ur = f.relate_record

	p ur.exec_unit.try(:name)
	p ur.exec_manager.try(:name)
	p ur.benefit_unit.try(:name)
	p ur.benefit_manager.try(:name)

	p f["amount"]
	p (rt = ur.usage_type).nil? ? "" : rt.name

	p f["comment"]

	audits = f.audits.reorder('version DESC')

	recorder, last_editor = (
		unless audits.empty?
			[User.find(audits.last.user_id).user.name,
			User.find(audits.first.user_id).user.name]
		else
			["",
			""]
		end
	)


	p recorder
	p last_editor

	p f['created_at']





	counter += 1

	puts counter if counter % 100 == 0


	# break

	@all << @arr
	# exit
end

rescue Exception => e
	binding.pry
end

# puts @arr.join(',')

File.open("used_fund_info.csv", "w") do |file|
	header = "所属项目\t日期\t执行单位\t批准人\t受益单位\t经办人\t使用本金\t用途\t备注\t录入人\t最后编辑人\t录入时间"
	header.split.join(',')
	file.puts header
	@all.each do |ar|
		file.puts ar.join(',')
	end
end
