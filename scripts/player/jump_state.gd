class_name PlayerJumpState
extends PlayerState

func enter(msg = {}) -> void:
	player.target_velocity.y = player.jump_impulse
	player.animation_player.stop()
	state_machine.transition_to("Fall")


func update(delta: float) -> void:
	pass


func physics_update(delta: float) -> void:
	pass

