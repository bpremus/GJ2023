extends PanelContainer

const Slot = preload("res://Inventory/slot.tscn")

@onready var character_grid = $MarginContainer/CharacterGrid

func _ready() -> void:
	var character_data = preload("res://test_inventory.tres")
	populate_character_grid(character_data.slot_datas)

func populate_character_grid(slot_datas: Array[SlotData]) -> void:
	for child in character_grid.get_children():
		child.queue_free()
		
	for slot_data in slot_datas:
		var slot = Slot.instantiate()
		character_grid.add_child(slot)

		if slot_data:
			slot.set_slot_data(slot_data)
			
