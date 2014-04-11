# puts = (args...) -> console.log(args)
$(document).ready ->
	# puts $('#employee-nav-bar-function-area').html()
	if $('#employee-nav-bar-function-area div').html() == ""
		$('#employee-nav-bar-function-area').hide()
# puts $('#employee-nav-bar-function-area')
