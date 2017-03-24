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
Fund.select_by_type(Fund.poly_types.actual_in).manage_view.order('time ASC').each do |f|
	@arr = []
	

	@fund = f
	time = f["time"]
	date = I18n.localize(time)
	p date.split[0]
	p f["amount"]
	dr = f.relate_record
	p dr.donation_type.try(:name) || "无"
	p f.currency.name


	origin_amount = f.origin_amount || ""

	p origin_amount


	p f["project_name"]

	# p f["relate_id"]

	cus = Customer.find_by(id: f["relate_id"])

	assert(cus.name == f["relate_name"])

	p cus.name

	ct = (
		case cus.customer_type
		when "IndividualCustomer"
			"个人客户"
		when "CorporateCustomer"
			"公司客户"
		when "CustomerGroup"
			"团体客户"
		else
			raise "wrong CT"
		end
	)

	p ct
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

	counter += 1

	puts counter if counter % 100 == 0


	# break

	@all << @arr
end

rescue Exception => e
	binding.pry
end

# puts @arr.join(',')

File.open("projects_info.csv", "w") do |file|
	header = "到账时间	到账金额	捐赠类型（现金、投资、利息……）	币种	原始金额	所属项目	捐赠客户	客户类型（个人、企业、团体）	备注	录入人	最后编辑人"
	header.split.join(',')
	file.puts header
	@all.each do |ar|
		file.puts ar.join(',')
	end
end