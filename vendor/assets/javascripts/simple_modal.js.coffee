root = exports ? this
root.getModalModule = ->
	ModalModule
class ModalModule
	@MASK: null
	@modals: {}
	@init: ->
		@maskInit()
		$('button[data-toggle="modal"]').each ->
			mm = new ModalModule($(this))
			ModalModule.modals[mm.id] = mm

	@maskInit: ->
		@mask = $('<div></div>')
		@mask.addClass('modal-mask')
		@mask.attr('')
		$('body').append(@mask)
		@mask.hide()
		ModalModule.MASK = @mask

	constructor: (button) ->
		@button = button
		@id = button.attr 'data-target'
		@dialog = $("##{@id}")
		@close = @dialog.children("[data-dismiss='modal']")
		console.log(@id)
		@mask = ModalModule.MASK
		@initButton()
		@initDialog()
		@setActivate(->)
		@setDeactivate(->)

	initButton: ->
		@button.click =>
			@activate()
			false
		@close.click =>
			@deactivate()

	initDialog: ->
		@dialog.hide()

	activate: ->
		@dialog.show()
		@mask.show()
		@activateCallBack()

	deactivate: ->
		@dialog.hide()
		@mask.hide()
		@deactivateCallBack()

	setActivate: (callback) ->
		@activateCallBack = callback

	setDeactivate: (callback) ->
		@deactivateCallBack = callback 


ready = ->
		ModalModule.init()

$(document).ready(ready)
$(document).on('page:load', ready)