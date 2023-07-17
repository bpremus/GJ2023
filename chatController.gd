extends Control

#character avatar prefab
var slotPrefab = preload("res://Inventory/slot.tscn")
@export var character_container : Control

func _ready():
	var character = gCharacter.new()
	character.name = "John Doe"
	character.age = 49
	character.location = "@attrium"
	addCharacter(character)
	character.name = "Maria Adams"
	character.location = "@main lobby"
	character.setTexture(1)
	addCharacter(character)

#keep track of characters 

#get click notification on charcter

func addCharacter(character : gCharacter) -> void : 
	var slot = slotPrefab.instantiate()
	character_container.add_child(slot)
	slot.instance()
	slot.setCharacter(character)
	
	pass

