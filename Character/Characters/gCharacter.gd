extends Resource
class_name gCharacter

@export var name: String = "John Doe"
@export var age : int = 42
@export var location : String = "@home"
@export var texture : Texture = preload("res://Images/avatar.png")


func setTexture(id: int) -> void:
	if id == 0:
		texture = preload("res://Images/avatar.png")
	if id == 1:
		texture = preload("res://Images/avatar2.png")
