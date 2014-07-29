
dosome = ->
	$("div.field").each ->
		if $(this).children("a[target='_blank']").size() > 0
			console.log $(this).children('select')


ready = ->
	# puts $('#employee-nav-bar-function-area').html()
	dosome()

$(document).ready(ready)
$(document).on('page:load', ready)