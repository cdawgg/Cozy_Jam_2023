extends StaticBody3D
class_name NPC

#add return for hacky sack
#shooting
var hackysack3 = load("res://hackysack3.tscn")
var b
@onready var muzzle = $Muzzle
#setup states
@onready var fsm = $FiniteStateMachine
@onready var idle_state = $FiniteStateMachine/IdleState
@onready var attack_state = $FiniteStateMachine/AttackState
@onready var attack_timer = $attacktimer

#interact
func _on_interactable_focused(interactor):
	pass # Replace with function body.

#interactables at https://www.youtube.com/watch?v=gTpteB2kRUc
func _on_interactable_interacted(interactor) -> void:
	print("can interact with")
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/dialogue_manager.dialogue"), "npc1")
	idle_state.hack_start
#


#connect check states
func _ready():
	#when player loses the ball change to the juggle_state
	idle_state.hack_start.connect(fsm.change_state.bind(attack_state))
	attack_state.hack_end.connect(fsm.change_state.bind(idle_state))
	
func _physics_process(delta):
	if gamestate.npc1_attack == true:
		fsm.change_state(attack_state)
		print("NPC attacking")
		#turn into one shoot, see state machine combo atk https://www.youtube.com/watch?v=QqNw9mcDehg
		#shoot()
	
func shoot():
		b = hackysack3.instantiate()
		b.position = muzzle.global_position
		b.transform.basis = muzzle.global_transform.basis
		get_parent().add_child(b)
		attack_timer.start()

#hacky sack recieved from player and change state, not working - collision setup wrong
func _on_collision_shape_3d_child_entered_tree(node):
	fsm.change_state(attack_state)
	gamestate.npc1_attack = false
	print("NPC recieved sack")
	
