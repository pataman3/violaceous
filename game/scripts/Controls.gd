extends Node
# Singleton for all controls

# Configurable control events
enum {LEFT, RIGHT, SPRINT, SELECT}


# Parses all input. If the input is one of the specified events,
# all nodes in the 'input' group will be notified with the
# event (one of the event constants) and the value (0 if unpressed,
# 1 if pressed, in the range [0,1] for joystick input).
# event: InputEvent
func _input(event):
	var result = null
	if event is InputEventKey:
		result = _parse_keyboard(event)
	elif event is InputEventJoypadMotion:
		result = _parse_joypad_motion(event)
	elif event is InputEventJoypadButton:
		result = _parse_joypad_button(event)
	
	if result != null:
		get_tree().call_group('input', 'input', result[0], result[1], result[1] != 0)


# Returns the value for the given event. See the definition of
# 'value' in the description for _input.
func get_value(event):
	return max(max(
		_get_value_keyboard(event),
		_get_value_joypad_motion(event)),
		_get_value_joypad_button(event)
	)


### Keyboard support ###

var key_to_event = {
	KEY_A: LEFT, KEY_LEFT: LEFT,
	KEY_D: RIGHT, KEY_RIGHT: RIGHT,
	KEY_SHIFT: SPRINT,
	KEY_SPACE: SELECT, KEY_E: SELECT
}

var event_to_keys = {
	LEFT: [KEY_A, KEY_LEFT],
	RIGHT: [KEY_D, KEY_RIGHT],
	SPRINT: [KEY_SHIFT],
	SELECT: [KEY_SPACE, KEY_E]
}

# event: InputEventKey
func _parse_keyboard(event):
	if event.echo:
		return null
	return [
		key_to_event[event.scancode],
		int(event.pressed)
	] if event.scancode in key_to_event else null

# event: one of the event constants
func _get_value_keyboard(event):
	if not event_to_keys.has(event):
		return 0
	for key in event_to_keys[event]:
		if Input.is_key_pressed(key):
			return 1
	return 0


### Joypad support ###

## Joystick ##

var threshold = 0.3

# index 0 is for negative axis values, 1 is for positive axis values
var joystick_to_events = {
	JOY_AXIS_0: [LEFT, RIGHT]
}

var event_to_joystick = {
	LEFT: JOY_AXIS_0,
	RIGHT: JOY_AXIS_0
}

func _parse_joypad_motion_helper(axis, axis_value):
	var index = 0 if axis_value < 0 else 1
	return [
		joystick_to_events[axis][index],
		abs(axis_value) if abs(axis_value) > threshold else 0
	] if axis in joystick_to_events else null

# event: InputEventJoypadMotion
func _parse_joypad_motion(event):
	return _parse_joypad_motion_helper(event.axis, event.axis_value)

# event: one of the event constants
func _get_value_joypad_motion(event):
	if not event_to_joystick.has(event):
		return 0
	var axis = event_to_joystick[event]
	var result = _parse_joypad_motion_helper(axis,Input.get_joy_axis(0, axis))
	return result[1] if result != null and result[0] == event else 0


## Joypad button ##

var button_to_event = {
	JOY_L: SPRINT, JOY_R: SPRINT,
	JOY_XBOX_X: SELECT, JOY_XBOX_A: SELECT, JOY_SONY_SQUARE: SELECT, JOY_SONY_X: SELECT
}

var event_to_buttons = {
	SPRINT: [JOY_L, JOY_R],
	SELECT: [JOY_XBOX_X, JOY_XBOX_A, JOY_SONY_SQUARE, JOY_SONY_X]
}

# event: InputEventJoypadButton
func _parse_joypad_button(event):
	return [
		button_to_event[event.button_index],
		int(event.pressed)
	] if event.button_index in button_to_event else null

# event: one of the event constants
func _get_value_joypad_button(event):
	if not event_to_buttons.has(event):
		return 0
	for button in event_to_buttons[event]:
		if Input.is_joy_button_pressed(0, button):
			return 1
	return 0
