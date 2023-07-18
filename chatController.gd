extends Control

#character avatar prefab
var slotPrefab = preload("res://Inventory/slot.tscn")
#chat line prefab
var chatLinePrefab = preload("res://chat_line.tscn")
@export var character_container : Control
@export var story_controller: Control
@export var chat_container : Control

var curentStoryBlock : Array

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
	
	loadStory()

#keep track of characters 
func loadStory() -> void:
	
	var story = story_controller.loadStoryText()
	curentStoryBlock = story_controller.getStorySegment(2, story)
	'''
	var segment = story_controller.getDialogSegment("start", curentStoryBlock)
	var dialog = story_controller.getSegementAsDialogObject(segment)

	for i in range(len(dialog.gcLines)):
		var line = dialog.gcLines[i]
		addNextChatLine(line)
	pass
	'''
	loadStoryNext("start")
	loadStoryNext("opt_sorry")
		
func loadStoryNext(tag : String) -> void:
	
	var segment = story_controller.getDialogSegment(tag, curentStoryBlock)

	var dialog = story_controller.getSegementAsDialogObject(segment)

	for i in range(len(dialog.gcLines)):
		var line = dialog.gcLines[i]
		addNextChatLine(line)
	pass
	
func addNextChatLine(chatLine : gcLine):
	var slot = chatLinePrefab.instantiate()
	chat_container.add_child(slot)
	slot.setLine(chatLine)
	pass
#get click notification on charcter

func addCharacter(character : gCharacter) -> void : 
	var slot = slotPrefab.instantiate()
	character_container.add_child(slot)
	slot.instance()
	slot.setCharacter(character)
	pass

