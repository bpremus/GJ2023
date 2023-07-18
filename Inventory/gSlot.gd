extends PanelContainer

@export var cName : Label
@export var cLocation : Label
@export var cTexture : TextureRect

var characterName : String = ""

func instance() -> void:
	pass

func setCharacter(character : gCharacter) -> void:
	if character:
		cTexture.texture = character.texture
		cName.text = character.name
		cLocation.text = character.location
		print("set character:" + character.name)
		characterName = character.name
	pass

func onHover() -> void:
	pass

func _on_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		print("set character:" + characterName)
		var node = get_node("/root/Node2D/ChatController")
		node.character_press(characterName)
	pass # Replace with function body.
