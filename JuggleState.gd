#state machine video: https://www.youtube.com/watch?v=qwOM3v8T33Q
class_name JuggleState
extends State

@export var actor: Player
@export var animator: AnimationPlayer
#@export var vision_cast: RayCast2D
@onready var ball = get_tree().get_nodes_in_group("NPC")[0]

#add UI for juggle mini-game
@onready var juggle_UI = $"../../JuggleUI"
#
signal found_ball
#
func _ready() -> void:
	set_physics_process(false)
#
func _enter_state() -> void:
	set_physics_process(true)
	animator.play("juggle")
	actor.player_freeze = true
	juggle_UI.show()
func _exit_state() -> void:
	set_physics_process(false)
	
func _physics_process(delta) -> void:
#	animator.scale.x = -sign(actor.velocity.x)
#	if animator.scale.x == 0.0: animator.scale.x = 1.0
#	var direction = Vector2.ZERO.direction_to(actor.get_local_mouse_position())
#	actor.velocity = actor.velocity.move_toward(direction * actor.max_speed, actor.acceleration * delta)
#	actor.move_and_slide()
#	if actor.is_colliding(ball):
#		found_ball.emit()
	pass
func _input(event):
	if event.is_action_pressed("action"):
		found_ball.emit()
		
