class_name CharacterCustomizer
extends Control

@onready var hair_transform: Node3D = $HSplitContainer/SubViewportContainer/SubViewport/Player/Character/Armature/Skeleton3D/Hair/Transform
@onready var head_transform: Node3D = $HSplitContainer/SubViewportContainer/SubViewport/Player/Character/Armature/Skeleton3D/Head/Transform
@onready var body_transform: Node3D = $HSplitContainer/SubViewportContainer/SubViewport/Player/Character/Armature/Skeleton3D/Body/Transform
@onready var left_hand_transform: Node3D = $HSplitContainer/SubViewportContainer/SubViewport/Player/Character/Armature/Skeleton3D/LeftHand/Transform
@onready var right_hand_transform: Node3D = $HSplitContainer/SubViewportContainer/SubViewport/Player/Character/Armature/Skeleton3D/RightHand/Transform
@onready var left_foot_transform: Node3D = $HSplitContainer/SubViewportContainer/SubViewport/Player/Character/Armature/Skeleton3D/LeftFoot/Transform
@onready var right_foot_transform: Node3D = $HSplitContainer/SubViewportContainer/SubViewport/Player/Character/Armature/Skeleton3D/RightFoot/Transform

@onready var head_primary_color: ColorPickerButton = $HSplitContainer/LeftPanel/MarginContainer/PartOptions/HeadPrimaryColor
@onready var head_secondary_color: ColorPickerButton = $HSplitContainer/LeftPanel/MarginContainer/PartOptions/HeadSecondaryColor

func _on_part_selected(type: PartType, part: CharacterPart) -> void:
	match(type):
		PartType.Hair:
			clear_children(hair_transform)
			hair_transform.add_child(instantiate_part(part))
			
		PartType.Head:
			clear_children(head_transform)
			head_transform.add_child(instantiate_part(part))
			
		PartType.Body:
			clear_children(body_transform)
			body_transform.add_child(instantiate_part(part))
			
		PartType.Hand:
			clear_children(left_hand_transform)
			clear_children(right_hand_transform)
			left_hand_transform.add_child(instantiate_part(part))
			right_hand_transform.add_child(instantiate_part(part))
			
		PartType.Foot:
			clear_children(left_foot_transform)
			clear_children(right_foot_transform)
			left_foot_transform.add_child(instantiate_part(part))
			right_foot_transform.add_child(instantiate_part(part))


func clear_children(node: Node3D) -> void:
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()


func instantiate_part(part: CharacterPart) -> Node3D:
	var modelScene = part.part_model.instantiate()
	var meshInstance = modelScene.get_child(0) as MeshInstance3D
	meshInstance.material_override = part.material
	
	return modelScene


enum PartType {
	Hair,
	Head,
	Body,
	Hand,
	Foot
}


func _on_head_secondary_color_color_changed(color):
	var meshInstance = head_transform.get_child(0).get_child(0) as MeshInstance3D
	var material = meshInstance.material_override as ShaderMaterial
	
	material.set_shader_parameter("secondary_color", color)


func _on_head_primary_color_color_changed(color):
	var meshInstance = head_transform.get_child(0).get_child(0) as MeshInstance3D
	var material = meshInstance.material_override as ShaderMaterial
	
	material.set_shader_parameter("primary_color", color)
