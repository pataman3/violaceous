extends KinematicBody2D

var message = "Stop turning me around!"

# called when the player interacts with this npc
func activate():
	print(message)
	set_scale(Vector2(-get_scale().x, 1))