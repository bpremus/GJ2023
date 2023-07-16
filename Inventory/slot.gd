extends PanelContainer

@onready var character_name = $MarginContainer/HFlowContainer/Name
@onready var character_texture = $MarginContainer/HFlowContainer/TextureRect

func set_slot_data(slot_data: SlotData) -> void:
	var character_data = slot_data.character_data
	character_texture.texture = character_data.texture
	tooltip_text = character_data.description
	character_name.text = character_data.name
	
