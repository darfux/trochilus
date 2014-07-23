# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

bindForm = ->
	$('#user-search-form').bind 'ajax:success', (data, status, xhr) ->
		checkboxInit()

checkboxInit = ->
	$('.user-check:checkbox').each ->
		checkbox = $(this)
		id = checkbox.attr('value')
		selectedAr = getCheckedusers()
		isSelected = $.inArray(id, selectedAr)
		if isSelected>=0
			checkbox.attr('disabled', 'disabled')
			checkbox.attr('checked', true)
		else
			$(this).click ->
				handleCheck(checkbox)

getCheckedusers = ->
	s = $('#selected-users')
	ar = []
	s.children().each ->
		ar.push $(this).children('input').attr('value')
	ar

handleCheck = (checkbox)->
	# alert(checkbox.attr('value'))
	id = checkbox.attr('value')
	link = $("#user-#{id}").clone()
	link.removeAttr('id')
	wrapper = $("<div id='user-#{id}-selected'></div>")
	$('#selected-users').append wrapper
	form_value = $("<input name='user[]' type='hidden' value='#{id}'>")
	deletor = $("<span class='selected-user-deletor'>x</span>")
	wrapper.append link
	wrapper.append form_value
	wrapper.append deletor
	deletor.click ->
		handleDeletor(id, wrapper)
	checkbox.attr('disabled', 'disabled')

handleDeletor = (id, user)->
	checkbox = $(".user-check:checkbox[value='#{id}']")
	checkbox.removeAttr('disabled')
	checkbox.attr('checked', false)
	user.remove()

ready = ->
	checkboxInit()
	bindForm()

$(document).ready(ready)
$(document).on('page:load', ready)