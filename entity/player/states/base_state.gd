extends Node
class_name State

var base: Node

signal request_transition(state: StringName)

func transition_state(state_name: String) -> void:
	request_transition.emit(state_name.to_lower())

func state_process(delta: float) -> void:
	pass

func state_process_physics(delta: float) -> void:
	pass

func state_enter() -> void:
	pass

func state_exit() -> void:
	pass