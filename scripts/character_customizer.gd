class_name CharacterCustomizer
extends Control

@onready var hair_transform: Node3D = $HSplitContainer/SubViewportContainer/SubViewport/Player/Character/Armature/Skeleton3D/Hair/Transform
@onready var head_transform: Node3D = $HSplitContainer/SubViewportContainer/SubViewport/Player/Character/Armature/Skeleton3D/Head/Transform
@onready var body_transform: Node3D = $HSplitContainer/SubViewportContainer/SubViewport/Player/Character/Armature/Skeleton3D/Body/Transform
@onready var left_hand_transform: Node3D = $HSplitContainer/SubViewportContainer/SubViewport/Player/Character/Armature/Skeleton3D/LeftHand/Transform
@onready var right_hand_transform: Node3D = $HSplitContainer/SubViewportContainer/SubViewport/Player/Character/Armature/Skeleton3D/RightHand/Transform
@onready var left_foot_transform: Node3D = $HSplitContainer/SubViewportContainer/SubViewport/Player/Character/Armature/Skeleton3D/LeftFoot/Transform
@onready var right_foot_transform: Node3D = $HSplitContainer/SubViewportContainer/SubViewport/Player/Character/Armature/Skeleton3D/RightFoot/Transform


func _on_part_selected(type: PartType, part: CharacterPart) -> void:
	match(type):
		PartType.Hair:
			clear_children(hair_transform)
			hair_transform.add_child(part.part_model.instantiate())
			
		PartType.Head:
			clear_children(head_transform)
			head_transform.add_child(part.part_model.instantiate())
			
		PartType.Body:
			clear_children(body_transform)
			body_transform.add_child(part.part_model.instantiate())
			
		PartType.Hand:
			clear_children(left_hand_transform)
			clear_children(right_hand_transform)
			left_hand_transform.add_child(part.part_model.instantiate())
			right_hand_transform.add_child(part.part_model.instantiate())
			
		PartType.Foot:
			clear_children(left_foot_transform)
			clear_children(right_foot_transform)
			left_foot_transform.add_child(part.part_model.instantiate())
			right_foot_transform.add_child(part.part_model.instantiate())


func clear_children(node: Node3D) -> void:
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()


enum PartType {
	Hair,
	Head,
	Body,
	Hand,
	Foot
}
