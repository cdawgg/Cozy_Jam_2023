#state machine video: https://www.youtube.com/watch?v=qwOM3v8T33Q
class_name TravelState
extends State

@export var actor: Player
@export var animator: AnimationPlayer
#@export var vision_cast: RayCast2D
#
signal lost_ball
#
func _ready() -> void:
	set_physics_process(false)
#
func _enter_state() -> void:
	set_physics_process(true)
	actor.player_freeze = false
func _exit_state() -> void:
	set_physics_process(false)

func _physics_process(delta) -> void:
#	animator.scale.x = -sign(actor.velocity.x)
#	if animator.scale.x == 0.0: animator.scale.x = 1.0
#	var direction = Vector2.ZERO.direction_to(actor.get_local_mouse_position())
#	actor.velocity = actor.velocity.move_toward(direction * actor.max_speed, actor.acceleration * delta)
#	actor.move_and_slide()
#	if vision_cast.is_colliding():
#		lost_player.emit()
	if actor.velocity.length() > 0:
		animator.play("move")
	else:
		animator.play("idle")
	
func _input(event):
	if event.is_action_pressed("action"):
		lost_ball.emit()
