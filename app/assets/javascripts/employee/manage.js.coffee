# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


# puts = (args...) -> console.log(args)
ready = ->
	# puts $('#employee-nav-bar-function-area').html()
	bar = $('#employee-nav-bar-function-area')
	bardiv = $('#employee-nav-bar-function-area div')
	bar.css("margin-left", -bar.outerWidth()/2)

$(document).ready(ready)
$(document).on('page:load', ready)
# puts $('#employee-nav-bar-function-area')
