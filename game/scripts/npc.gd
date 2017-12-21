# this code will be unused until 
# TextInterfaceEngine is added again

extends KinematicBody2D

# the TextInterfaceEngine for the dialog box
onready var dialog = get_node("dialog_box/dialog_box_text")


# called when the player interacts with this npc
func activate():
	# show the dialog box
	get_node("dialog_box").set_hidden(false)
	
	# clear text
	dialog.buff_clear()
	
	# change color to white
	dialog.set_color(Color(1, 1, 1))
	
	# buffer wisdom
	dialog.buff_text("Sometimes, " , 0.07)
	dialog.buff_silence(0.3)
	dialog.buff_text("a dog needs to die.", 0.07)
	
	# set the dialog to output mode
	dialog.set_state(dialog.STATE_OUTPUT)
