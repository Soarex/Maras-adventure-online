extends Control

func _on_part_selected(part: CharacterPart, type: PartType) -> void:
	match(type):
		PartType.Hair:
			CharacterCustomizationState.CurrentHair.Value = part
			
		PartType.Head:
			CharacterCustomizationState.CurrentHead.Value = part
			
		PartType.Body:
			CharacterCustomizationState.CurrentBody.Value = part
			
		PartType.Hand:
			CharacterCustomizationState.CurrentHand.Value = part
			
		PartType.Foot:
			CharacterCustomizationState.CurrentFoot.Value = part


enum PartType {
	Hair,
	Head,
	Body,
	Hand,
	Foot
}
