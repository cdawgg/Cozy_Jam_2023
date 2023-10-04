#state machine video: https://www.youtube.com/watch?v=qwOM3v8T33Q
class_name FiniteStateMachine
extends Node

@export var state: State

func _ready():
	change_state(state)

func change_state(new_state: State):
	if state is State:
		state._exit_state()
	new_state._enter_state()
	state = new_state
