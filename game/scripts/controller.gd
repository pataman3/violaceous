extends KinematicBody2D

# x velocity
var x_velocity = 0

# default walking/running speeds
export var RUN_SPEED  = 1.3
export var WALK_SPEED = 0.9

# keyboard inputs for actions
var move_right_keys   = [KEY_D, KEY_RIGHT]
var move_left_keys    = [KEY_A, KEY_LEFT]
var run_keys          = [KEY_SHIFT]
var activation_keys   = [KEY_SPACE]


# called when the game starts
func _ready():
	$activation_area


# called at fixed intervals (60 fps)
func _physics_process(delta):
	move_and_collide(Vector2(x_velocity, 0))


# returns true if any of the keys in key_array are pressed
func _is_key_pressed(key_array):
	for key in key_array:
		if Input.is_key_pressed(key):
			return true
	return false


# called whenever an input is recieved
func _input(event):
	# only keyboard events are supported at the moment
	if not event is InputEventKey:
		return
	# do not process echoed keys
	if event.is_echo():
		return
	
	# check if any movement keys are pressed
	x_velocity = 0 # don't move if none are pressed
	if _is_key_pressed(move_right_keys):
		x_velocity = WALK_SPEED
	if _is_key_pressed(move_left_keys):
		x_velocity = -WALK_SPEED
	if _is_key_pressed(run_keys):
		x_velocity = RUN_SPEED * sign(x_velocity)
	
	# face the correct direction
	if x_velocity != 0:
		$sprite.set_flip_h(x_velocity < 0)
	
	# check if the player is activating something
	if _is_key_pressed(activation_keys):
		# also possible to check Area2D.get_ovelapping_areas()
		var bodies = $activation_area.get_overlapping_bodies()
		# currently does not choose which one to activate in any meaningful way
		if bodies.size() > 0 and bodies[0].has_method("activate"):
			bodies[0].activate()
	
	# determine which movement animation to use
	var anim = "run"
	if -WALK_SPEED <= x_velocity and x_velocity <= WALK_SPEED:
		anim = "walk"
	if x_velocity == 0:
		anim = "idle"
	# only play the animation if it's not already playing
	if $animator.get_current_animation() != anim:
		$animator.play(anim)

