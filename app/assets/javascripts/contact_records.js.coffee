# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
customer_modal = user_modal = null

customerFormAction = (data)->
	customer_modal.deactivate()
	for obj in data
		handleCustomerData(obj) #because of closure scope
	false

handleCustomerData = (obj)->
	id = obj['value']
	wrapper = $("<div id='customer-#{id}'></div>")
	form_value = $("<input name='customer[]' type='hidden' value='#{id}'>")
	deletor = $("<span class='selected-deletor'>  x</span>")
	link = obj['link']
	wrapper.append link
	wrapper.append form_value
	wrapper.append deletor
	handleDeletor(id, wrapper)
	deletor.click ->
		handleDeletor(id, wrapper)
	$('#customer-result').append wrapper

userFormAction = (data)->
	user_modal.deactivate()
	for obj in data
		handleUserData(obj) #because of closure scope
	false

handleUserData = (obj)->
	id = obj['value']
	wrapper = $("<div id='user-#{id}'></div>")
	form_value = $("<input name='user[]' type='hidden' value='#{id}'>")
	deletor = $("<span class='selected-deletor'>  x</span>")
	link = obj['link']
	wrapper.append link
	wrapper.append form_value
	wrapper.append deletor
	handleDeletor(id, wrapper)
	deletor.click ->
		handleDeletor(id, wrapper)
	$('#user-result').append wrapper

handleDeletor = (id, wrapper)->
	wrapper.remove()

ready = ->
	if judgeCurrentController('contact_records')
		customer_modal = getModalModule().modals['select-customer']
		user_modal = getModalModule().modals['select-user']
		customer_modal.setDeactivate ->
			$('#selected-customers').empty()
			$('.employee-common-list-cell').empty()
		user_modal.setDeactivate ->
			$('#selected-users').empty()
			$('.employee-common-list-cell').empty()
		regCutomerSelectFormAction(customerFormAction)
		regUserSelectFormAction(userFormAction)

$(document).ready(ready)
$(document).on('page:load', ready)