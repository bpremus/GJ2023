extends Control

@export var characters : Array
@export var charactersJson : String = "res://Resources/_characters.json"
@export var locationsJson : String = "res://Resources/_locations.json"
@export var chatJson : String = "res://Resources/_chat.json"

@export var _currentLocationID : int = 1
var rng = RandomNumberGenerator.new()
var chatServices :chatDecision = chatDecision.new()
#tags 


# game characters and stats
var _characters 
var _factions
var _locations
var _dialogs
var _player
var _gossip
var _offer

func _ready() -> void:
	# var json = loadJson()
	# loadCharacters(json)
	pass	

#new 
func getGreeting(character):
	
	chatServices.setData(_characters,_locations)
	chatServices.findSecret(character, _characters)
	
	return chatServices.getGreeting(character,_dialogs)

func getOptionNext(character, lastLine):
	return chatServices.getFallowUpOptions(character, _dialogs, lastLine)

#---------------------------------------------------



func assembleCommunication(character):
	var chatSegment = []
	
	#star first small talk with character
	var greeting = chatServices.getIntroduction(character, _dialogs)
	if (greeting) :
		chatSegment.append(greeting)
	
	# our response
	var response = chatServices.getFallowUpChat(character, _dialogs, chatSegment)
	if (response) :
		chatSegment.append(response)
	
	
	# offer
	
	# gossip
	
	chatServices.setTag(character,chatServices.INT_BEFORE)
	return chatSegment
	pass

func getLinkedConversationNext(character, option):
	'''
	var chatSegment = []

	var response = chatServices.getFallowUpChat(character, _dialogs, option)
	if (response) :
		chatSegment.append(response)
	
	return chatSegment
	'''
	pass

func getCharacterByID(id: int):
	for i in range(len(_characters)):
		if _characters[i].character.id == id:
			return _characters[i].character 
			
func getLocation():
	return getLocationByID(_currentLocationID)

func getLocationByID(id: int):
	for i in range(len(_locations)):
		if _locations[i].id == _currentLocationID:
			return _locations[i] 

#check if character will show on the scene
func isCharacterAvailable(character) -> bool:
	
	#checks current scene
	
	#check tags
	
	return true
	
func willCharacterTalkToUs(character) -> bool:
	
	#check rank
	
	#check tags 
	
	#check likeness
	
	return false

func getCharactersOnScene() -> Array:
	var characters = []
	for i in range(len(_characters)):
		var locIDs = _characters[i].character.locationID;
		for ii in range(len(locIDs)):
			if (_currentLocationID == locIDs[ii]):
				characters.append(_characters[i].character.id)
	
	#sort from higher to lower 
	characters.sort_custom(func(a, b): return a > b)
	return characters

func loadDialogs(json_data) -> void:
	var data = json_data
	_dialogs = data.dialogs
#load locations
func loadLocations(json_data) -> void:
	var data = json_data
	_locations = data.locations

#init characters, connect everything
func loadCharacters(json_data) -> void:
	var data = json_data

	_characters = data.characters
	
	_factions  = data.factions
	
	_player = data.player
	
	for i in range(len(_characters)):
		
		#these are hard connections
		setMaster(_characters[i].character)
		setFamily(_characters[i].character)

		#these are soft connections		
		#work and political connections
		#based on location, political prefrence
		setSoftConnections(_characters[i].character)
		
		#dump
	#for i in range(len(_characters)):
		#dumpCharacter(_characters[i].character)
	pass

func setMaster(master) -> void:

	for i in range(len(_characters)):
		var servant = _characters[i].character
		if (servant.id == master.id) :
			continue
		
		if isRankBelow(master, servant) :
			if (servant.id not in master.servants) :
				master.servants.append(servant.id)
				
			if (master.id not in servant.master) :
				servant.master.append(master.id)
		
		#_characters[i].character = servant
	pass

func setFamily(master) -> void:
	for i in range(len(_characters)):
			var family = _characters[i].character
			if (family.id == master.id) :
				continue

			#add family member 
			if (family.family == master.family):
				if (family.id not in master.connections):
					master.connections.append(family.id)
				if (master.id not in family.connections):
					family.connections.append(master.id)
	pass

func setSoftConnections(master) -> void:
	
	
	pass

func setFaction(character):
	var id = character.faction
	for i in range(len(_factions)):
			if (_factions[i].id == id):
				return _factions[i].name
	return null
	
func dumpCharacter(character) -> void:
	print ("Id          ",character.id)
	print ("Name        ",character.name)
	print ("Faction     ",setFaction(character))
	print ("Age         ",character.age)
	print ("Rank        ",character.rank)
	print ("Loc         ",character.locationID)
	print ("Occ         ",character.occupation)
	print ("Master	    ",character.master)
	print ("Servants    ",character.servants)
	print ("Connections ",character.connections)
	print("\n")
	
	pass

func isRankBelow(master, servant) -> bool :
	if (master.faction == servant.faction):
		if (master.rank > servant.rank) :
			return true
	return false
	pass

func loadJson(type):
	var json_string = ""
	if (type == "dialogs"):
		json_string = LoadResource(chatJson)
	if (type == "character"):
		json_string = LoadResource(charactersJson)
	if (type == "locations"):
		json_string = LoadResource(locationsJson)
	var json = JSON.new()
	var error = json.parse(json_string)
	return json.data

func addCharacter(char : gCharacter) -> void:
	pass

func LoadResource(path : String ) -> String:
	var file = FileAccess.open(path, FileAccess.READ)
	var content = file.get_as_text()
	return content
	
