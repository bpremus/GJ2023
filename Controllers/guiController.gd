extends Control

@export var characterPrafab = preload("res://Inventory/slot.tscn")
@export var chatLinePrefab = preload("res://chat_line.tscn")
@export var characterNode : Control
@export var chatNode : Control

var _location
var _player

func setPlayer(player) -> void:
	_player = player

func showScene(scene) -> void:
	pass
	
func setBackgroundPicture() -> void:
	pass
	
func setLocation(location) -> void:
	_location = location
	pass
	
func setCharacter(character) -> void:
	var slot = characterPrafab.instantiate()
	characterNode.add_child(slot)
	slot.setCharacter(character)
	slot.setLocation(_location)
	pass

func setConversationOption(character, options) -> Control:
	var slot = chatLinePrefab.instantiate()
	chatNode.add_child(slot)
	slot.setCharacter(character)
	slot.setPlayer(_player)
	slot.setAsPlayerOptions(options)
	return slot

func setConversationLine(character) -> Control:
	var slot = chatLinePrefab.instantiate()
	chatNode.add_child(slot)
	slot.setCharacter(character)
	slot.setPlayer(_player)
	return slot
	pass

func cleanConversationLine() :
	var children = chatNode.get_children()
	for c in children:
		chatNode.remove_child(c)
		c.queue_free()
	pass
