extends Resource
class_name chatDecision
var rng = RandomNumberGenerator.new()

var _characters
var _locations

#enogh for small talk
var INT_NEW		  = "new"
var INT_BEFORE    = "met"
var INT_SEEN  	  = "seen"
var INT_LIKED     = "like"
var INT_DISLIKED  = "dislike"
var SAME_FAMILY   = "family"
var SAME_PARTY	  = "party"
var RIVAL_PARTY	  = "opparty"
var FLERTED		  = "flerted"
var KNOWS_SOMETH  = "know"
var FAVOR	      = "favor"

func setData(characters, locations):
	_characters = characters
	_locations = locations

func findSecret(character, characters) :
	print ("\findSecret")
	
	var filterList = []
	
	if (hasTag2(character, INT_BEFORE)):
		for i in range(len(character.connections)):
			var id = character.connections[i]
			var others = getCharacterByID(characters,id)
			for ii in range(len(others.secret)):
				var secret = others.secret[ii]
				print(character.name , "knows that ", others.name, " is connected with ", secret.hint )
				filterList.appen(secret)
	
	print (character.connections)
	return filterList
	pass
	
func getGreeting(character, dialogs):
	print ("\ngetGreeting")

	# to simplify, always character talks first, we are sending like silent hello
	var greeting_character = dialogs.character.greeting
	var greeting_player    = dialogs.player.greeting
	
	var filterList = []
	#interraction with a new character
	var tag = INT_NEW
	if (hasTag(character,INT_BEFORE) == false):
		setTag(character,INT_NEW)
	else:
		tag = INT_BEFORE
	
	var greetings = getListWithAllTags(greeting_character,[tag])
	var answer = pickAnswer(character,greetings)
	if (answer):
		answer.player = false
		filterList.append(answer)
	
	#response
	var start = true
	var isPlayer = true
	while hasFallowup(answer) or start:
		if (isPlayer) : 
			greetings = getResponse(character,greeting_player,answer)
		else:
			greetings = getResponse(character,greeting_character,answer)
			
		answer = pickAnswer(character,greetings)
		if (answer):
			answer.player = isPlayer
			filterList.append(answer)
			
		if (isPlayer) : 
			isPlayer = false
		else: 
			isPlayer = true
		start = false
		pass
	
	#set tags 
	setTag(character,INT_BEFORE)
	removeTag(character,INT_NEW)
	
	return filterList
	pass

func pickAnswer(character, dialogs):
	
	#if only one
	if len(dialogs) == 0 : return null
	if len(dialogs) == 1 :	return dialogs[0]
	
	#random 
	var i = rng.randi_range(0, len(dialogs)-1)
	return dialogs[i]
	pass

func getFallowUpOptions(character, dialogs, lastResponse):
	
	var options_player    = dialogs.player.options
	var options_character = dialogs.character.greeting
	
	#does a play know something?
	
	var options = getListWithTags(options_player,[KNOWS_SOMETH, FAVOR])
	
	#var smalltalk = dialogs.smalltalk
	#var gossip = dialogs.gossip
	#var offer = dialogs.offer
	
	#var options = getAllConnectingList(character, smalltalk, "")
	return options
	pass

func hasFallowup(lastAnswer):
	if (lastAnswer) :
		if ("followup" in lastAnswer) :
			return true
	return false

func getResponse(character, dialog, lastAnswer):
	print ("\ngetResponse")
	
	# var filterList = []
	var greetings = []
	if (lastAnswer) :
		if hasFallowup(lastAnswer):
			var fallowupTag = lastAnswer.followup
			print ("fallowupTag => ", fallowupTag)
			greetings = getListWithAllTags(dialog,fallowupTag)	
		else:
			greetings = getListWithAllTags(dialog,lastAnswer.tags)	
	
	print ("getResponse => ", greetings)
	return greetings
	pass

func getListWithAllTags(elementList, tags):
	var filterList = []
	#print (elementList, len(tags))
	for i in range(len(elementList)):
			var found = true
			for ii in range(len(tags)):
				if hasTag2(elementList[i],tags[ii]) == false:
					found = false
					#ii = len(tags)
					# print(tags[ii], "\t" ,elementList[i].tags)
					
			# we have all tags
			if (found) :
				filterList.append(elementList[i])
	return filterList

func getListWithTags(elementList, tags):
	var filterList = []
	#print (elementList, len(tags))
	for i in range(len(elementList)):
			var found = false
			for ii in range(len(tags)):
				if hasTag2(elementList[i],tags[ii]) == true:
					found = true

			# we have all tags
			if (found) :
				filterList.append(elementList[i])
	return filterList

func filterOnTag(character, elementList, tag):
		#filter if they dont like us, but they have options for that
	var filterList = []
	for i in range(len(elementList)):
		if hasTag(character,tag):
			if hasTag(elementList[i],tag):
				filterList.append(elementList[i])
		else:
			if hasTag(elementList[i],tag) == false:
				filterList.append(elementList[i])

	if (len(filterList)):
		elementList = filterList
	return elementList
	
func getVisibleList(character, greetings):
	var rank = character.rank
	var validResponses = []
	#filter down what we can
	for i in range(len(greetings)):
		if (rank != greetings[i].rank):
			continue
			
		# have we met before?
		if hasTag(character,INT_BEFORE):
			if hasTag(greetings[i],INT_BEFORE):
				validResponses.append(greetings[i])		
		else:
			if hasTag(greetings[i],INT_BEFORE) == false:
				validResponses.append(greetings[i])
				
	return validResponses

func getIntroduction(character, dialog):
	
	var greetings = dialog.greetings
	var faction = character.faction

	#filter down based on have we seen the character before or not
	var validResponses = getVisibleList(character,greetings)
		
	#are we not liked?
	validResponses = filterOnTag(character,validResponses, INT_DISLIKED)
			
	#filter based on faction
	var cleanList = []
	for i in range(len(validResponses)):
		if (faction != validResponses[i].faction):
			if (len(validResponses) > 1):
				continue
		cleanList.append(validResponses[i])
	validResponses = cleanList
	
	#pick one 
	var i = rng.randi_range(0, len(validResponses)-1)
	if (len(validResponses)) :
		validResponses[i].player = false
		return validResponses[i]
	return null
	pass
	
func  getAllConnectingList(character, elementList, tags):
	var rank = character.rank
	var validResponses = []
	#filter down what we can
	for i in range(len(elementList)):
		
		# we should find all chats that can connect
		validResponses.append(elementList[i])
				
	return validResponses
#generic 
func getFilteredList(character, elementList, tags):
	var rank = character.rank
	var validResponses = []
	#filter down what we can
	for i in range(len(elementList)):
		if (rank != elementList[i].rank):
			continue
		# have we met before?
		if hasTag(character,tags):
			if hasTag(elementList[i],tags):
				validResponses.append(elementList[i])		
		else:
			if hasTag(elementList[i],tags) == false:
				validResponses.append(elementList[i])
				
	return validResponses
	
func geLinkedUpChat(character, dialog, lastResponse, isPlayer : bool):
	
	var validResponses = []
	
	
	
	pass
	
func getFallowUpChat(character, dialogs, lastResponse):
	
	var secret = findSecret(character,_characters)
	
	'''
	var responses = dialogs.ourResponses
	var tags = lastResponse[0].tags
	
	var validResponses = getFilteredList(character,responses,INT_BEFORE)
	
	#pick one 
	var i = rng.randi_range(0, len(validResponses)-1)
	if (len(validResponses)) :
		validResponses[i].player = true
		return validResponses[i]
	return null
	
	'''
	pass
		
func setTag(character, tag):
	if (tag not in character.tags):
		character.tags.append(tag)

func hasTag(character, tag):
	if (tag in character.tags):
		return true
	return false
	
func hasTag2(character, tag : String):
	for i in range(len(character.tags)):
		if str(character.tags[i]) == str(tag):
			return true
	return false		
	
func removeTag(character, tag):
	var newTags = [];
	for i in range(len(character.tags)):
		if character.tags[i] == str(tag):
			continue
		newTags.append(character.tags[i])
	character.tags = newTags

func interractedBefore(character) -> bool:
	if (INT_BEFORE in character.tags):
		return true
	return false

func getCharacterByID(characters, id: int):
	for i in range(len(characters)):
		if characters[i].character.id == id:
			return characters[i].character 
			
