extends NinePatchRect

#
# A system for using a live-updating dialog box
#
# Usage:
#    1. Add lines using the `say` method
#    2. Add options for the player to respond with using `listen`
#    3. Call `start`
#

# [[String, AudioSteamPlayer] ...]
# The lines of dialog that will be spoken to the player,
# paired with the (possibly null) voice spoken for each letter.
var lines = []

# [[String, String] ...]
# The options the player will be presented to respond with.
# If null, the player will not be given any options.
# The first String is the response text, and the second String
# is the paragraph to advance to if that response is chosen.
# Use `null` as the paragraph if you want the dialog to end instead.
var options = null


# (String, AudioStreamPlayer)
# Adds a line of text to be displayed
# line : The line of text being displayed
# voice : The sound played for each letter. If `null`, nothing is played.
func say(line, voice = null):
	lines.append([line, voice])


# ([[String, String] ...])
# Allows the player to choose between different lines of dialog.
# options : See Manager.options
func listen(options):
	self.options = options


func start():
	if len(lines) == 0 and options == null:
		return
	ActiveCutscene.start_action(self)
	show()
	$Line.set_process_input(true)
	advance_dialog()


func advance_dialog():
	if len(lines) > 0:
		$Line.say(lines[0][0], lines[0][1])
		lines.pop_front()
	else:
		$Line.set_process_input(false)
		if options == null:
			finish()
		else:
			$Options.start(options)


func finish(path = null):
	hide()
	options = null
	ActiveCutscene.finish_action(self, path)
