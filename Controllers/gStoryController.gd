extends Control

@export var characterController : Control
@export var uiController : Control

# Called when the node enters the scene tree for the first time.
func _ready():
	loadGame()
	setScene()
	pass # Replace with function body.


func characterPress(id : int) -> void:
	var character = characterController.getCharacterByID(id)
	
	#start with greeting
	var greeting = characterController.getGreeting(character)
	uiController.cleanConversationLine()

	var line
	for i in range(len(greeting)):
		line = uiController.setConversationLine(character)
		line.setDialogData(greeting[i])
	
	var options = characterController.getOptionNext(character,line)
	line = uiController.setConversationOption(character, options)
		
func conversationOptionPress(_character, option):
	var line = characterController.getLinkedConversationNext(character, option)
	print(line)
	pass
	
# load scenes 
func loadGame() -> void:
	
	var chat_json = characterController.loadJson("dialogs")
	characterController.loadDialogs(chat_json)
	var char_json = characterController.loadJson("character")
	characterController.loadCharacters(char_json)
	var loc_json = characterController.loadJson("locations")
	characterController.loadLocations(loc_json)
	pass
	
	
# queue scenes 
func setScene() -> void:
	
	#set scene ID
	characterController._currentLocationID = 1
	#build scene
	var location = characterController.getLocation()
	uiController.setLocation(location)
	uiController.setPlayer(characterController._player)

	var chars = characterController.getCharactersOnScene()
	setCharacters(chars)

	pass

# scheduler

func setCharacters(characterIDs) -> void:
	for i in range(len(characterIDs)):
		var character = characterController.getCharacterByID(characterIDs[i])
		uiController.setCharacter(character)

#dequeu scene
func nextScene() -> void:
	
	pass
	
func setSceneCharacters() -> void:
	
	pass
	
func setTimer() -> void:
	
	pass
