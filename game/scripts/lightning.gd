extends CanvasModulate

# time since the last lightning strike in seconds
var next_flash = 0

# the current color of the tint
export var darkness_tint = Color(.4, .4, .4, 1)

# on average it will take this long between each flash
export var frequency = 10


# called on start
func _ready():
	next_flash = flash_time()
	set_process(true)


# called every frame
func _process(delta):
	var c = get("color").linear_interpolate(darkness_tint, delta * 2)
	set("color", c)


# flash lighting
func flash():
	set("color", Color(1, 1, 1, 1))
	next_flash = flash_time()


# called every second
func _second_tick():
	next_flash -= 1
	if next_flash == 0:
		flash()


# returns a random number in the range [1, frequency * 2]
func flash_time():
	return (randi() % (frequency * 2)) + 1


