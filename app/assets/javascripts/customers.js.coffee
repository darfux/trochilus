# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

bindForm = ->
	$('#customer-search-form').bind 'ajax:success', (data, status, xhr) ->
		checkboxInit()

checkboxInit = ->
	$('.customer-check:checkbox').each ->
		checkbox = $(this)
		id = checkbox.attr('value')
		selectedAr = getCheckedCustomers()
		isSelected = $.inArray(id, selectedAr)
		if isSelected>=0
			checkbox.attr('disabled', 'disabled')
			checkbox.attr('checked', true)
		else
			$(this).click ->
				handleCheck(checkbox)

getCheckedCustomers = ->
	s = $('#selected-customers')
	ar = []
	s.children().each ->
		ar.push $(this).children('input').attr('value')
	ar

handleCheck = (checkbox)->
	# alert(checkbox.attr('value'))
	id = checkbox.attr('value')
	link = $("#customer-#{id}").clone()
	link.removeAttr('id')
	wrapper = $("<div id='customer-#{id}-selected'></div>")
	$('#selected-customers').append wrapper
	form_value = $("<input name='customer[]' type='hidden' value='#{id}'>")
	deletor = $("<span class='selected-customer-deletor'>x</span>")
	wrapper.append link
	wrapper.append form_value
	wrapper.append deletor
	deletor.click ->
		handleDeletor(id, wrapper)
	checkbox.attr('disabled', 'disabled')

handleDeletor = (id, customer)->
	checkbox = $(".customer-check:checkbox[value='#{id}']")
	checkbox.removeAttr('disabled')
	checkbox.attr('checked', false)
	customer.remove()

# handleForm = ->
#   $('#customer-select-form').submit (event) ->
#     true
#   # $('#customer-select-form').unbind('')
#   $('#customer-select-form').submit (event) ->
#     console.log $('#customer-select-form').serializeArray()[2..-1]
#     # alert 2
#     false
#     # true
ready = ->
	checkboxInit()
	bindForm()

$(document).ready(ready)
$(document).on('page:load', ready)


	# $('#customer-select-form').submit (event) ->
	# 	# alert(1)
	# 	for obj in $('#customer-select-form').serializeArray()
	# 		# console.log obj
	# 		if obj['name'] == 'customer'
	# 			# console.log $("#customer-#{obj['value']}")
	#       link = $("#customer-#{obj['value']}").clone()
	#       link.attr('id', "#customer-#{obj['value']}-selected")
	#       $('#selected-customers').append link
	#       link.wrap('<div></div>')
	#       # console.log link
	#               # $('.customer-check:checkbox').each(function () {
	#       #     $(this).click(function(){

	#    #                $(this).attr("checked", false);
	#       #       });
	#    #            });
	# 	false