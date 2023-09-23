extends Node

@export var initial_state: State

@onready var base := get_parent() 	# this isnt dumb bc state machine not expected to
									# function without parent
var states: Dictionary = {}
var current_state: State

func _ready() -> void:
	for child in get_children():
		if child is State:
			var state := child as State
			states[state.name.to_lower()] = state
			state.base = base
			state.request_transition.connect(go_to_state)
	if initial_state:
		current_state = initial_state
		initial_state.state_enter()

func go_to_state(state_name: String) -> void:
	var state := states[state_name.to_lower()] as State
	if state:
		if current_state:
			current_state.state_exit()
		current_state = state
		state.state_enter()

func _process(delta: float) -> void:
	if current_state: current_state.state_process(delta)

func _physics_process(delta: float) -> void:
	if current_state: current_state.state_process_physics(delta)
