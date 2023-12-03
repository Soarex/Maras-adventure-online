class_name StateMachine
extends RefCounted

signal transitioned(state_name)

var current_state: State 
var states := Dictionary()


func register_state(state: State, name: String) -> void:
	state.state_machine = self
	states[name] = state
	
	
func transition_to(target_state_name: String, msg := {}) -> void:
	if not states.has(target_state_name):
		return
		
	if current_state:
		current_state.exit()
		
	current_state = states[target_state_name]
	current_state.enter()
	transitioned.emit(target_state_name)
	
	
func handle_input(event: InputEvent) -> void:
	current_state.handle_input(event)
	
	
func update(delta: float) -> void:
	current_state.update(delta)
	
	
func physics_update(delta: float) -> void:
	current_state.physics_update(delta)
	
