extends KinematicBody2D

# Character Class.

# (String)
# A cutscene action for speaking a line of dialog.
func says(line):
	DialogBox.get_node("DialogBox").say(line, null)

