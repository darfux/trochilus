root = exports ? this

root.judgeCurrentController = (name)->
	controller = $('#controller-mark')
	controller && controller.attr('name') == name

createFormReg = ->
	root.regCutomerSelectFormAction = (action) ->
		$('#customer-select-form').submit (event) ->
			data = $('#customer-select-form').serializeArray()[2..-1]
			for obj in data
				id = obj['value']
				link = $("#customer-#{id}-selected").children('a')
				obj['link'] = link
			action(data)
	root.regUserSelectFormAction = (action) ->
		$('#user-select-form').submit (event) ->
			data = $('#user-select-form').serializeArray()[2..-1]
			for obj in data
				id = obj['value']
				link = $("#user-#{id}-selected").children('a')
				obj['link'] = link
			action(data)

formUploadValidate = ->
	$('form[enctype="multipart/form-data"]').submit (event) ->
		file = $('form[enctype="multipart/form-data"]').children('input[type="file"]').val()
		if file==""
			alert('请选择要上传的文件')
			false
		else
			true
			
ready = ->
  createFormReg()
  formUploadValidate()


$(document).ready(ready)
$(document).on('page:load', ready)