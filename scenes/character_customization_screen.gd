extends Control

@export var character_customization_data: CharacterCustomizationData

@onready var hair_options_container: VBoxContainer = $HSplitContainer/LeftPanel/MarginContainer/PartOptions/HairOptionMargin/HairOptions
@onready var head_options_container: VBoxContainer = $HSplitContainer/LeftPanel/MarginContainer/PartOptions/HeadOptionMargin/HeadOptions
@onready var body_options_container: VBoxContainer = $HSplitContainer/LeftPanel/MarginContainer/PartOptions/BodyOptionMargin/BodyOptions
@onready var hand_options_container: VBoxContainer = $HSplitContainer/LeftPanel/MarginContainer/PartOptions/HandOptionMargin/HandOptions
@onready var foot_options_container: VBoxContainer = $HSplitContainer/LeftPanel/MarginContainer/PartOptions/FeetOptionMargin/FeetOptions


func _ready():
	for hair in character_customization_data.hairs:
		var entry := Label.new()
		entry.text = hair.name
		#entry.data = null
		
		hair_options_container.add_child(entry)
		
	for head in character_customization_data.heads:
		var entry := Label.new()
		entry.text = head.name
		#entry.data = null
		
		head_options_container.add_child(entry)
		
	for body in character_customization_data.bodies:
		var entry := Label.new()
		entry.text = body.name
		#entry.data = null
		
		body_options_container.add_child(entry)
		
	for hand in character_customization_data.hands:
		var entry := Label.new()
		entry.text = hand.name
		#entry.data = null
		
		hand_options_container.add_child(entry)
		
	for foot in character_customization_data.feet:
		var entry := Label.new()
		entry.text = foot.name
		#entry.data = "Test"
		
		foot_options_container.add_child(entry)
