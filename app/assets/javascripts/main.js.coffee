# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
puts = (args...) -> console.log(args)

puts $('#employee-nav-bar-function-area')
if $('#employee-nav-bar-function-area').html() == ""
	$('#employee-nav-bar-function-area').hide
