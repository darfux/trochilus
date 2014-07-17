# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
panel = mask= null

showPanel = ->
	mask.show()
	panel.show()

hidePanel = ->
	panel.hide()
	mask.hide()
	panel.reset()

linkManFormAction = (data)->	
	hidePanel()
	for obj in data
		handleData(obj) #because of closure scope
	false

handleData = (obj)->
	console.log(obj)
	id = obj['value']
	wrapper = $("<div id='group-customer-#{id}'></div>")
	form_value = $("<input name='customer[]' type='hidden' value='#{id}'>")
	deletor = $("<span class='group-customer-deletor'>  x</span>")
	link = obj['link']
	wrapper.append link
	wrapper.append form_value
	wrapper.append deletor
	handleDeletor(id, wrapper)
	deletor.click ->
		handleDeletor(id, wrapper)
	$('#group-customer-result').append wrapper

handleDeletor = (id, customer)->
	customer.remove()

buttonInit = ->
	$('#go-select-customer').click ->
		showPanel()
		false

panelInit = ->
	hidePanel()
	panel.children('.close').click ->
		hidePanel()

ready = ->
	if judgeCurrentController('customer_groups')
		panel = $('#customer-select-panel')
		panel.reset = ->
			$('#selected-customers').empty()
			$('.employee-common-list-cell').empty()
		mask = $('.modal-mask')
		buttonInit()
		panelInit()
		regCutomerSelectFormAction(linkManFormAction)

$(document).ready(ready)
$(document).on('page:load', ready)