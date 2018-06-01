File.open("projects_info.csv", "w") do |file|
	Project.all.where("create_date >= ?", Date.new(,05,18)).manage_view.each do |project|
		time = project.create_date
		date =  I18n.localize(time)
		file.puts %Q|"#{project.name}","#{project[:type]}","#{project[:level]}","#{project[:unit]}","#{project.endowment_t}","#{project[:total_amount]}","#{project[:rest_amount]}", "#{date}", "#{project.brief}"|
		# break
	end
end
