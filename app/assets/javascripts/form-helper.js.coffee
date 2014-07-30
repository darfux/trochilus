
root = exports ? this

getFormHref = ->
	href = window.location.href
	if href.match(/.*s$/)
		href += '/new'
	if href.match(/.*s\/\d+$/)
		href += '/edit'
	href

dosome = ->
	form = $('.common-form')
	return if form.length == 0
	form_wrap = $(form[0])
	form = form_wrap.children('form').first()
	return if $('div.field').children('a').length == 0
	refresh = $("<a href=''>刷新</a>")
	wait = $("<div style='color: gray'>请等待...</div>")
	refresh.click ->
		$(this).hide()
		wait.show()
		form = form_wrap.children('form').first()
		formdata = form.serialize()
		that = $(this)
		$.ajax({
			url: getFormHref(),
			type: 'GET',
			async: true,
			success: (res)-> 
				that.show()
				wait.hide()
				new_form = $(res).find('form').first()
				new_form.deserialize(formdata)
				# form.replaceWith new_form
				form = form_wrap.children('form').first()
				form.replaceWith(new_form)
		})

		false
	form_wrap.prepend(refresh)
	form_wrap.prepend(wait)
	wait.hide()
	# $("div.field").each ->
	# 	if $(this).children("a[target='_blank']").size() > 0
	# 		console.log $(this).children('select')


ready = ->
	# puts $('#employee-nav-bar-function-area').html()
	dosome()

$(document).ready(ready)
$(document).on('page:load', ready)