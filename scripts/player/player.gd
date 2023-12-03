@tool
class_name Player
extends CharacterBody3D

@export var player := 1 :
	set(id):
		player = id
		$PlayerCharacterInput.set_multiplayer_authority(id)
		#$InputSynchronizer.set_multiplayer_authority(id)
		$CameraArm.set_multiplayer_authority(id)

@export var speed := 14.0
@export var sprint_speed := 19.0
@export var fall_acceleration := 75.0
@export var jump_impulse := 20.0
@export var bounce_impulse := 16.0
@export var camera_follow_speed := 8.0
@export var attack_duration := 0.5
@export var attack_dash_speed := 20.0
@export var attack_rotation_speed := 36.0
@export var color := Color.AQUA

@onready var input: CharacterInput = $PlayerCharacterInput
@onready var spring_arm: SpringArm3D = $CameraArm
@onready var camera: Camera3D = $CameraArm/Camera
@onready var pivot: Node3D = $Character
@onready var character: Node3D = $Character/Armature
@onready var particle_system: GPUParticles3D = $Character/ParticleSystem
@onready var animation_player: AnimationPlayer = $Character/AnimationPlayer

var target_velocity := Vector3.ZERO
var state_machine := StateMachine.new()

func get_camera_space_direction() -> Vector3:
	var rotated_direction = input.direction
	rotated_direction = rotated_direction.rotated(Vector3.UP, spring_arm.rotation.y).normalized()
	
	if rotated_direction != Vector3.ZERO:
		rotated_direction = rotated_direction.normalized()
	
	return rotated_direction


func handle_rotation(delta: float) -> void:
	pivot.rotation.x = PI / 6 * velocity.y / jump_impulse
	var look_direction = Vector2(-velocity.z, -velocity.x)
	
	if(look_direction):
		pivot.rotation.y = lerp_angle(pivot.rotation.y, look_direction.angle(), delta * 12)
		

func register_states() -> void:
	state_machine.register_state(PlayerIdleState.new(self), "Idle")
	state_machine.register_state(PlayerFallState.new(self), "Fall")
	state_machine.register_state(PlayerJumpState.new(self), "Jump")
	state_machine.register_state(PlayerRunState.new(self), "Run")
	state_machine.register_state(PlayerAttackState.new(self), "Attack")


func _ready() -> void:
	if Engine.is_editor_hint():
		return
		
	if player == multiplayer.get_unique_id():
		camera.current = true
		
	register_states()
	state_machine.transition_to("Idle")
	
	
func _process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
		
	state_machine.update(delta)


func _unhandled_input(event: InputEvent) -> void:
	if Engine.is_editor_hint():
		return
		
	state_machine.handle_input(event)


func _physics_process(delta: float) -> void:
	if Engine.is_editor_hint():
		return
		
	state_machine.physics_update(delta)
	
	velocity = target_velocity
	move_and_slide()
	
	handle_rotation(delta)
	spring_arm.position = lerp(spring_arm.position, position, delta * camera_follow_speed)


func _get_configuration_warning():
	var has_input = false

	for child in get_children():
		if child is CharacterInput:
			has_input = true

	if !has_input:
		return "This node has no input, so it can't move. Consider adding a CharacterInput node"

	return ""

