extends KinematicBody2D

# children of this node
onready var animator = get_node("animator")
onready var sprite = get_node("sprite")

# gravity is the speed the player falls in pixels/sec
var GRAVITY = 10;

# velocity
var velocity = Vector2(0, GRAVITY)

# default walking/running speeds
export var RUN_SPEED = 7
export var WALK_SPEED = 3.30

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
	if (is_colliding()):
        move(get_collision_normal().slide(velocity))

	move(velocity)


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
		velocity.x = WALK_SPEED
	elif Input.is_key_pressed(KEY_A) or Input.is_key_pressed(KEY_LEFT):
		velocity.x = -WALK_SPEED
	else:
		velocity.x = 0
	
	if Input.is_key_pressed(KEY_SHIFT) and velocity.x != 0:
		velocity.x = RUN_SPEED * sign(velocity.x)


# called by _input when a joystick input is recieved
func _joystick_input(event):
	velocity.x = Input.get_joy_axis(0, JOY_AXIS_0) * RUN_SPEED
	if abs(velocity.x) < WALK_MIN:
		velocity.x = 0


# sets the animation based on Ramona's velocity
func _set_anim():
	var current_anim = animator.get_current_animation()
	
#	var next_anim = "ramona_run"
#	if -WALK_SPEED <= x_vel and x_vel <= WALK_SPEED:
#		next_anim = "ramona_walk"
#	if x_vel == 0:
#		next_anim = "ramona_idle"
#	
#	if current_anim != next_anim:
#		animator.play(next_anim)
	
	if velocity.x != 0:
		sprite.set_flip_h(velocity.x < 0)
