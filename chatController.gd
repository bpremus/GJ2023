extends Control

#character avatar prefab
var slotPrefab = preload("res://Inventory/slot.tscn")
#chat line prefab
var chatLinePrefab = preload("res://chat_line.tscn")
@export var character_container : Control
@export var story_controller: Control
@export var chat_container : Control

var curentStoryBlock : Array
var charactersInStoryBlock : Array
var activeCharacter : String

# Handler method for response_press
func response_press(tag : String):
	print("clicked:", tag)
	loadStoryNext(tag, activeCharacter)
	
func character_press(character : String) -> void:
	activeCharacter = character
	removeChatLines()
	loadStoryNext("start", activeCharacter)
	pass

func autostartChapterStory() -> void:
	loadStoryNext("start", "auto")
	pass

func _ready():
	'''
	var character = gCharacter.new()
	character.name = "John Doe"
	character.age = 49
	character.location = "@attrium"
	addCharacter(character)
	character.name = "Maria Adams"
	character.location = "@main lobby"
	character.setTexture(1)
	addCharacter(character)
	'''

	loadStory()
	setActiveCharacters()
	autostartChapterStory()
	
func setActiveCharacters() -> void:
	for i in range(len(charactersInStoryBlock)):
		var character = gCharacter.new()
		print(charactersInStoryBlock[i])
		character.name = charactersInStoryBlock[i]
		if character.name == "Narrator" : 
			continue
		addCharacter(character)
	

#keep track of characters 
func loadStory() -> void:
	
	var story = story_controller.loadStoryText()
	curentStoryBlock = story_controller.getStorySegment("23", story)
	charactersInStoryBlock = story_controller.getCharactersInScene(curentStoryBlock)

		
func loadStoryNext(tag : String, characterTag : String) -> void:
	
	#var characters = story_controller.getCharactersInScene()
	var segment = story_controller.getDialogSegment(tag, characterTag , curentStoryBlock)
	var dialog = story_controller.getSegementAsDialogObject(segment)

	for i in range(len(dialog.gcLines)):
		var line = dialog.gcLines[i]
		await get_tree().create_timer(0.5).timeout
		addNextChatLine(line)
	pass
	
func addNextChatLine(chatLine : gcLine):
	var slot = chatLinePrefab.instantiate()
	chat_container.add_child(slot)
	slot.setLine(chatLine)
	pass
#get click notification on charcter

func removeChatLines() -> void:
	var children = chat_container.get_children()
	for c in children:
		chat_container.remove_child(c)
		c.queue_free()
	pass

func addCharacter(character : gCharacter) -> void : 
	var slot = slotPrefab.instantiate()
	character_container.add_child(slot)
	slot.instance()
	slot.setCharacter(character)
	pass

