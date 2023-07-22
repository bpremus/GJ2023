extends PanelContainer

@export var cName : Label
@export var cLocation : Label
@export var cTexture : TextureRect
@export var avatarFolder = "res://Images/avatars/"

var _character

func instance() -> void:
	pass
	
func setLocation(location) -> void:
	#cLocation.text = "@" +location.name
	cLocation.text = "#" + _character.occupation
	pass

func setCharacter(character) -> void:
	_character = character
	cName.text = character.name
	var path = avatarFolder + str(character.id) + ".png"
	cTexture.texture = load(path)
	

func _on_gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		#print("set character:" + characterName)
		var node = get_node("/root/Main/Story")
		node.characterPress(_character.id)
	pass # Replace with function body.
