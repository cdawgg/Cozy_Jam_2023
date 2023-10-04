extends RigidBody3D

#homing target
var move_speed = 5

@export var animator: AnimationPlayer

@onready var target = get_tree().get_nodes_in_group("NPC")[0]


func _ready() -> void:
	body_entered.connect(_on_bullet_body_entered)
	animator.play("toss")
	
func _physics_process(delta: float) -> void:

	if target == null:
		position += move_speed * Vector3(0, 1, 0) * delta

	if target != null:
		look_at(target.global_position)
		position = position.move_toward(target.global_position, move_speed * delta)

func _on_bullet_body_entered(body: Node3D) -> void:
	if body.is_in_group("NPC"):
		#add state to return hacky sack with chance to fumble
		#body.queue_free() destroys NPC object - do not want, but good ref
		print("hacky NPC")
	if body.is_in_group("Player"):
		#add state to volley hacky sack with minigame
		print("hacky player")
	queue_free()


func _on_timer_timeout():
	queue_free()

#decent enemy to player tutorial https://www.youtube.com/watch?v=x5-I4kkbdvo
