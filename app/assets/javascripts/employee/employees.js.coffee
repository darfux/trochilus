# puts = (args...) -> console.log(args)
$(document).ready ->
	# puts $('#employee-nav-bar-function-area').html()
	bar = $('#employee-nav-bar-function-area')
	bardiv = $('#employee-nav-bar-function-area div')
	if bardiv.html() == ""
		bar.hide()
	else
		bar.css("margin-left", -bar.outerWidth()/2)
# puts $('#employee-nav-bar-function-area')
