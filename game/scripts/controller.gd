extends Node2D

# children of this node
onready var animator = get_node("animator")
onready var sprite = get_node("sprite")

# x velocity
var x_velocity = 0

# default walking/running speeds
export var RUN_SPEED  = 7.0
export var WALK_SPEED = 3.3

# the minimum speed to move
var WALK_MIN = 1

# currently supported control inputs
var supported_inputs = [InputEvent.KEY, InputEvent.JOYSTICK_MOTION]

# keyboard inputs for actions
var move_right_keys = [KEY_D, KEY_RIGHT]
var move_left_keys  = [KEY_A, KEY_LEFT]
var run_keys        = [KEY_SHIFT]


# called on start
func _ready():
	set_process_input(true) # recieve input events
	set_fixed_process(true) # run code at fixed framerate


# called roughly every frame at fixed intervals
func _fixed_process(delta):
	translate(Vector2(x_velocity, 0))


# called whenever an input is recieved
func _input(event):
	if not event.type in supported_inputs:
		return
	
	if event.type == InputEvent.KEY:
		_key_input(event)
	elif event.type == InputEvent.JOYSTICK_MOTION:
		_joystick_input(event)
	_set_anim()

# returns true if any of the keys in key_array are pressed
func _is_key_pressed(key_array):
	for key in key_array:
		if Input.is_key_pressed(key):
			return true
	return false
	
# called by _input when a key input is recieved
func _key_input(event):
	# ignore repeating keys
	if event.is_echo():
		return
	
	# call event.scancode to get the key just pressed / released
	# call event.pressed to get whether the key was pressed or released
	
	# check if any movement keys are pressed
	x_velocity = 0 # don't move if none are pressed
	if _is_key_pressed(move_right_keys):
		x_velocity = WALK_SPEED
	if _is_key_pressed(move_left_keys):
		x_velocity = -WALK_SPEED
	if _is_key_pressed(run_keys):
		x_velocity = RUN_SPEED * sign(x_velocity)


# called by _input when a joystick input is recieved
func _joystick_input(event):
	x_velocity = Input.get_joy_axis(0, JOY_AXIS_0) * RUN_SPEED
	# don't move with input below the joystick theshold
	if abs(x_velocity) < WALK_MIN:
		x_velocity = 0


# sets the animation based on Ramona's velocity
func _set_anim():
	
#	var current_anim = animator.get_current_animation()
#	var next_anim = "ramona_run"
#	if -WALK_SPEED <= x_vel and x_vel <= WALK_SPEED:
#		next_anim = "ramona_walk"
#	if x_vel == 0:
#		next_anim = "ramona_idle"
#	
#	if current_anim != next_anim:
#		animator.play(next_anim)
	
	if x_velocity != 0:
		sprite.set_flip_h(x_velocity < 0)
