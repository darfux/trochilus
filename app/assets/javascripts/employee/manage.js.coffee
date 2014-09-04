# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

initTableFilters = ->
	$('.filter').children('select').each ->
		$(this).change ->
			params = {}
			$('.filter').children('select').each ->
				console.log $(this).val()
				if val = $(this).val()
					filter = $(this).attr('id')
					params ||= {}
					params[filter] = val
					# console.log params
			params = $.query.set('filters', params)
			# console.log $.query.parseNew(location.search, location.hash), location.search
			# console.log window.location.pathname
			if params.toString()
				location.search = params
			else
				location.href = location.pathname


# puts = (args...) -> console.log(args)
ready = ->
	# puts $('#employee-nav-bar-function-area').html()
	bar = $('#employee-nav-bar-function-area')
	bardiv = $('#employee-nav-bar-function-area div')
	bar.css("margin-left", -bar.outerWidth()/2)
	initTableFilters()

$(document).ready(ready)
$(document).on('page:load', ready)
# puts $('#employee-nav-bar-function-area')
