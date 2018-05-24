extends ScrollContainer

# TODO :
#   + Add keyboard support (or replace mouse support with keyboard support)
#   + Wrap lines when they're too long

# PackedScene
# A reference the DialogOption scene
var dialog_option = preload('res://dialog/DialogOption.tscn')


# [[String, String] ...]
# options : See Manager.options
func start(options):
	for option in options:
		var button = dialog_option.instance()
		button.create(option[0], option[1])
		$VBoxContainer.add_child(button)
	set_v_scroll(0)
	show()


# (String)
# Called by a DialogOption to indicate which line was selected.
# next_paragraph : The paragraph to advance to next
func option_selected(next_paragraph):
	finish()
	get_parent().finish(next_paragraph)


func finish():
	# safely deletes each DialogOption
	for button in $VBoxContainer.get_children():
		button.queue_free()
	hide()
