extends Sprite

# children of this node
onready var anim = get_node("anim")

# horizontal velocity
var x_vel = 0

# default walking/running speeds
export var RUN_SPEED = 7
export var WALK_SPEED = 3.35

# the minimum speed to move
var WALK_MIN = 1

# currently supported control inputs
var supported_inputs = [InputEvent.KEY, InputEvent.JOYSTICK_MOTION]



# called on start
func _ready():
	set_process_input(true)
	set_process(true)


# called every frame
func _process(delta):
	move_local_x(x_vel)


# called whenever an input is recieved
func _input(event):
	if not event.type in supported_inputs:
		return
	
	if event.type == InputEvent.KEY:
		_key_input(event)
	elif event.type == InputEvent.JOYSTICK_MOTION:
		_joystick_input(event)
	_set_anim()


# called by _input when a key input is recieved
func _key_input(event):
	# call event.scancode to get the key just pressed / released
	# should probably call event.is_echo() to check for repeat inputs
	if Input.is_key_pressed(KEY_D) or Input.is_key_pressed(KEY_RIGHT):
		x_vel = WALK_SPEED
	elif Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		x_vel = -WALK_SPEED
	else:
		x_vel = 0
	
	if Input.is_key_pressed(KEY_SHIFT) and x_vel != 0:
		x_vel = RUN_SPEED * sign(x_vel)


# called by _input when a joystick input is recieved
func _joystick_input(event):
	x_vel = Input.get_joy_axis(0, JOY_AXIS_0) * RUN_SPEED
	if abs(x_vel) < WALK_MIN:
		x_vel = 0


# sets the animation based on Ramona's x_vel
func _set_anim():
	var current_anim = anim.get_current_animation()
	
	var next_anim = "ramona_run"
	if -WALK_SPEED <= x_vel and x_vel <= WALK_SPEED:
		next_anim = "ramona_walk"
	if x_vel == 0:
		next_anim = "ramona_idle"
	
	if current_anim != next_anim:
		anim.play(next_anim)
	
	if x_vel != 0:
		set_flip_h(x_vel < 0)
