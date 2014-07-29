# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
modal = null

linkManFormAction = (data)->
	modal.deactivate()
	for obj in data
		handleData(obj) #because of closure scope
	false

handleData = (obj)->
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

ready = ->
	if judgeCurrentController('customer_groups')
		modal = getModalModule().modals['myModal']
		modal.setDeactivate ->
			$('#selected-customers').empty()
			$('.employee-common-list-cell').empty()
		regCutomerSelectFormAction(linkManFormAction)

$(document).ready(ready)
$(document).on('page:load', ready)