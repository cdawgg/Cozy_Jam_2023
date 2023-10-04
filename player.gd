extends CharacterBody3D
class_name Player

const SPEED = 5.0
#const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

#shooting
var hackysack = load("res://hackysack.tscn")
var b
@onready var muzzle = $Muzzle
#setup states
@onready var fsm = $FiniteStateMachine
@onready var travel_state = $FiniteStateMachine/TravelState as TravelState
@onready var juggle_state = $FiniteStateMachine/JuggleState as JuggleState
@onready var attack_timer = $attacktimer
#add player freeze var to stop movement in juggle
var player_freeze = false
#connect check states
func _ready():
	#when player loses the ball change to the juggle_state
	travel_state.lost_ball.connect(fsm.change_state.bind(juggle_state))
	juggle_state.found_ball.connect(fsm.change_state.bind(travel_state))
	
func _unhandled_input(event: InputEvent) -> void:
	# Add shooting
	if Input.is_action_just_pressed("action") and attack_timer.is_stopped():
		shoot()
	# Handle Jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
	#	velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#if player_freeze == false:
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta


	#flip sprite depending on direciton moving
	if velocity.x > 0:
		$Sprite3D.flip_h = false
	elif velocity.x < 0: 
		$Sprite3D.flip_h = true


	move_and_slide()

# Add shooting https://www.youtube.com/watch?v=6bbPHsB9TtI
func shoot():
	b = hackysack.instantiate()
	b.position = muzzle.global_position
	b.transform.basis = muzzle.global_transform.basis
	get_parent().add_child(b)
	attack_timer.start()
	#add homing https://www.youtube.com/watch?v=bqyDm0MmGqg&t=740s

#enter and leave cave scene
func _on_cave_body_entered(body):
	get_tree().change_scene_to_file("res://cave.tscn")
func _on_cave_exit_body_entered(body):
	get_tree().change_scene_to_file("res://world.tscn")
