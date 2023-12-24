class_name CharacterPartOptions
extends VBoxContainer

signal part_selected

@export var character_customization_data: CharacterCustomizationData
@export var header_name: String

@onready var title: RichTextLabel = $Title
@onready var options_container: VBoxContainer = $OptionsMargin/Options
@onready var primary_color_button: ColorPickerButton = $HBoxContainer/PrimaryColor
@onready var secondary_color_button: ColorPickerButton = $HBoxContainer/SecondaryColor


func _ready():
	title.text = header_name
	for part in character_customization_data.parts:
		var entry := Label.new()
		entry.text = part.name

		entry.mouse_filter = Control.MOUSE_FILTER_PASS
		entry.gui_input.connect(func(event):
			if(event is InputEventMouseButton && event.pressed && event.button_index == 1):
				on_part_selected(part, character_customization_data.part_type))
				
		options_container.add_child(entry)


func set_primary_color(color: Color):
	primary_color_button.color = color
	

func set_secondary_color(color: Color):
	secondary_color_button.color = color


func on_part_selected(part: CharacterPart, part_type: Variant) -> void:
	part_selected.emit(part, part_type)
