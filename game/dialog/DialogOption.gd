extends Button

# Node
# A reference to the node that created this Option
onready var options = get_parent().get_parent()

# String
# The paragraph to advance to if this Option is selected.
var paragraph


# (String, String)
# Contructor for Options.
# line : The dialog option shown
# paragraph : See Option.paragraph
func create(line, paragraph):
	text = line
	self.paragraph = paragraph

# Called when the option is selected.
func _on_press():
	options.option_selected(paragraph)
