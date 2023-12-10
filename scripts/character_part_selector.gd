class_name CharacterPartSelector
extends VBoxContainer

@export var character_customization_data: CharacterCustomizationData

@onready var hair_options_container: VBoxContainer = $HairOptionMargin/HairOptions
@onready var head_options_container: VBoxContainer = $HeadOptionMargin/HeadOptions
@onready var body_options_container: VBoxContainer = $BodyOptionMargin/BodyOptions
@onready var hand_options_container: VBoxContainer = $HandOptionMargin/HandOptions
@onready var foot_options_container: VBoxContainer = $FeetOptionMargin/FeetOptions


func _ready():
	for hair in character_customization_data.hairs:
		var entry := Label.new()
		entry.text = hair.name

		entry.mouse_filter = Control.MOUSE_FILTER_PASS
		entry.gui_input.connect(func(event):
			if(event is InputEventMouseButton && event.pressed && event.button_index == 1):
				on_part_selected(hair))
		
		hair_options_container.add_child(entry)
		
	for head in character_customization_data.heads:
		var entry := Label.new()
		entry.text = head.name
		
		entry.mouse_filter = Control.MOUSE_FILTER_PASS
		entry.gui_input.connect(func(event):
			if(event is InputEventMouseButton && event.pressed && event.button_index == 1):
				on_part_selected(head))
		
		head_options_container.add_child(entry)
		
	for body in character_customization_data.bodies:
		var entry := Label.new()
		entry.text = body.name
		
		entry.mouse_filter = Control.MOUSE_FILTER_PASS
		entry.gui_input.connect(func(event):
			if(event is InputEventMouseButton && event.pressed && event.button_index == 1):
				on_part_selected(body))
		
		body_options_container.add_child(entry)
		
	for hand in character_customization_data.hands:
		var entry := Label.new()
		entry.text = hand.name
		
		entry.mouse_filter = Control.MOUSE_FILTER_PASS
		entry.gui_input.connect(func(event):
			if(event is InputEventMouseButton && event.pressed && event.button_index == 1):
				on_part_selected(hand))
		
		hand_options_container.add_child(entry)
		
	for foot in character_customization_data.feet:
		var entry := Label.new()
		entry.text = foot.name
		
		entry.mouse_filter = Control.MOUSE_FILTER_PASS
		entry.gui_input.connect(func(event):
			if(event is InputEventMouseButton && event.pressed && event.button_index == 1):
				on_part_selected(foot))
		
		foot_options_container.add_child(entry)


func on_part_selected(part: CharacterPart) -> void:
	print(part.name)
