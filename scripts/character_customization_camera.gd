extends SpringArm3D

@export var mouse_sensitivity := 0.05
@export var controller_sensitivity := 1

func _ready() -> void:
	top_level = true


func _physics_process(delta: float) -> void:
	rotation_degrees.x -= (Input.get_action_strength("camera_down") - Input.get_action_strength("camera_up")) * controller_sensitivity
	rotation_degrees.x = clamp(rotation_degrees.x, -60, -5)
	
	rotation_degrees.y -= -(Input.get_action_strength("camera_left") - Input.get_action_strength("camera_right")) * controller_sensitivity
	rotation_degrees.y = wrapf(rotation_degrees.y, 0, 360)
	

func _input(event: InputEvent) -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) else Input.MOUSE_MODE_VISIBLE
	if event is InputEventMouseMotion && Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		rotation_degrees.x -= -event.relative.y * mouse_sensitivity
		rotation_degrees.x = clamp(rotation_degrees.x, -60, -5)
		
		rotation_degrees.y -= event.relative.x * mouse_sensitivity
		rotation_degrees.y = wrapf(rotation_degrees.y, 0, 360)
