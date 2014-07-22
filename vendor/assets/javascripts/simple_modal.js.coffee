modal_target_id = null
buttonInit = ->
	$('button[data-toggle="modal"]').each ->
		$(this).click ->
			alert(1)
			false

ready = ->
		# body = $('#simple-modal-body')
		# mask = $('.modal-mask')
		buttonInit()
		# panelInit()
		# regCutomerSelectFormAction(linkManFormAction)

$(document).ready(ready)
$(document).on('page:load', ready)