extends "res://scripts/Character.gd"

var x_velocity = 0.0

var JOGGING_SPEED = 0.9
var SPRINTING_SPEED  = 1.3

onready var selection_area = $SelectionArea
onready var animator = $Animator
onready var sprite = $Sprite

# called a a fixed interval (60 fps)
func _physics_process(delta):
	move_and_collide(Vector2(x_velocity, 0))


# called if relevant input is recieved
# event: one of the Control singleton contants
# value: the input value in the range [0, 1]
# pressed: true if the event is pressed (alias for value != 0)
func input(event, value, pressed):
	x_velocity = (Controls.get_value(Controls.RIGHT) - \
		Controls.get_value(Controls.LEFT)) * JOGGING_SPEED
	if Controls.get_value(Controls.SPRINT):
		x_velocity = sign(x_velocity) * SPRINTING_SPEED
	if pressed and event == Controls.SELECT:
		var bodies = selection_area.get_overlapping_bodies()
		if bodies.size() > 0 and bodies[0].has_method('activate'):
			bodies[0].activate()
	
	var anim = null
	match abs(x_velocity):
		0.0: anim = 'idle'
		SPRINTING_SPEED: anim = 'run'
		_: anim = 'run'
	if animator.get_current_animation() != anim:
		animator.play(anim)
	if x_velocity != 0:
		sprite.set_flip_h(x_velocity < 0)

