class_name PlayerCharacterInput
extends CharacterInput

func _ready():
	set_process(get_multiplayer_authority() == multiplayer.get_unique_id())


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump"):
		jump.rpc()
		
	if Input.is_action_just_pressed("attack"):
		attack.rpc()
		
	sprinting = Input.is_action_pressed("sprint")
	
	direction = Vector3.ZERO
	direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	direction.z = Input.get_action_strength("move_back") - Input.get_action_strength("move_forward")
	
	input_magnitude = clampf(direction.length(), 0, 1)
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()


@rpc("call_local")
func jump():
	jump_requested = true
	
	
@rpc("call_local")
func attack():
	attack_requested = true
