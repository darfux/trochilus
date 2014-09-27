# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

initTableFilters = ->
	$('.filter').children('select').each ->
		$(this).change ->
			f = $.query.get('filters')
			f ||= {}
			filter = $(this).attr('id')
			if $(this).val()
				f[filter] = $(this).val()
			else
				delete f[filter]
			params = $.query.set('filters', f)
			if params.toString()
				location.search = params
			else
				location.href = location.pathname

	for elm in ['from', 'to']
		((type)->
			$("#fund_time_#{type}").change ->
				f = $.query.get('filters')
				f ||= {}
				time_key = 'time'
				f[time_key] ||= {}
				if $(this).val()
					f[time_key][type] = $(this).val()
				else
					delete f[time_key][type]
					if f[time_key] == {}
						delete f[time_key]
				location.search = $.query.set('filters', f))(elm)

		((type)->
			$("#project_time_#{type}").change ->
				f = $.query.get('filters')
				f ||= {}
				time_key = 'create_date'
				f[time_key] ||= {}
				if $(this).val()
					f[time_key][type] = $(this).val()
				else
					delete f[time_key][type]
					if f[time_key] == {}
						delete f[time_key]
				location.search = $.query.set('filters', f))(elm)
			

ready = ->
	# puts $('#employee-nav-bar-function-area').html()
	bar = $('#employee-nav-bar-function-area')
	bardiv = $('#employee-nav-bar-function-area div')
	bar.css("margin-left", -bar.outerWidth()/2)
	initTableFilters()

$(document).ready(ready)
$(document).on('page:load', ready)
# puts $('#employee-nav-bar-function-area')
