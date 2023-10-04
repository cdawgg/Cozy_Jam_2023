extends Control

@onready var bar = $TextureProgressBar
var speed = 1.0
var accel = 1.0

func _ready():
	#hide()
	pass
func _process(delta):
	if bar.value >= 0 and not 100:
		bar.value += delta * speed
	if bar.value == 100:
		bar.value -= delta * speed

func set_value(value):
	bar.value = value
	if value < 101:
		show()
	#else:
		#hide()
