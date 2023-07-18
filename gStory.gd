extends Control

#story document
const storyText : String = "res://story.txt"
const characterText : String = "res://characters.txt"

func _ready():
	pass

func loadChapter(index: int) -> void:
	pass

func getCharactersInScene(storyBlock: Array) -> Array:
	var characters = []
	for i in range(len(storyBlock)):
		var line = storyBlock[i]
		if isDialogLine(line):
			var character = getCharacterName(line)
			if character not in characters:
				characters.append(character)
			
	print (characters)
	return characters
	pass

func loadStoryText() -> String:
	return loadStory(storyText)

func getCharacterFromString(characterName : String) -> gCharacter:
	var char  = gCharacter.new()
	return char

func loadStory(story_path : String ) -> String:
	var file = FileAccess.open(story_path, FileAccess.READ)
	var content = file.get_as_text()
	return content
	
func isStart(line : String) -> bool:
	if line.find("start :=") > -1 :
		return true
	return false
	
func isStartTag(line : String, tag : String) -> bool:
	if line.find("start :=") > -1 :
		var tagLine = line.split(":=")[1]
		if tagLine.strip_edges() == tag:
			return true
	return false
	
func isEnd(line : String) -> bool:
	if line.find("end :=") > -1 :
		return true
	return false
	
func isGoTo(line : String) -> bool:
	if line.find("goto :=") > -1 :
		return true
	return false

func isGoToTag(line : String, tag : String) -> bool:
	if line.find("goto :=") > -1 :
		var tagLine = line.split("goto :=")[1]
		if tagLine.strip_edges() == tag:
			return true
	return false
		
func isOption(line : String) -> bool:
	if line.find("option :=") > -1 :
		return true
	return false
			
func isDialogLine(line: String) -> bool:
	if (isOption(line) or isGoTo(line) or isEnd(line) or isStart(line)): 
		return false
	if len(line.split(":=")) == 2: 
		return true
	return false

func getCharacterName(line : String) -> String:
	return line.split(":=")[0].strip_edges()
	
func getCharacterText(line: String) -> String:
	return line.split(":=")[1].strip_edges()
			
func getOptionText(line : String) -> String:
	return line.split(":=")[1].strip_edges()
	pass

func getOptionTag(line : String) -> String:
	return line.split(":=")[2].strip_edges()
	pass	
	
func getSegementAsDialogObject(storyBlock : Array):
	var dailogObj = gcDialog.new()
	var loption = gcLine.new()
	
	for i in range(len(storyBlock)):
		var line = storyBlock[i]
		
		if (isOption(line)):
			var lresponse = gcResponse.new()
			lresponse.text = getOptionText(line)
			lresponse.gotoLine = getOptionTag(line)
			loption.response.append(lresponse)
		
		if isDialogLine(line) :
			var l = gcLine.new()
			l.characterName = getCharacterName(line)
			l.text = getCharacterText(line)
			#add dialog lines			
			dailogObj.gcLines.append(l)
			
	if (len(loption.response)) :
		dailogObj.gcLines.append(loption)
	return dailogObj
				
func getDialogSegment(segmentTag : String, startTag : String, storyBlock: Array):
	var storyBlocks = []
	var found = false
	for i in range(len(storyBlock)):
		var line = storyBlock[i]
		#print (line)
		#if we are seraching from start
		if segmentTag == "start" : 
			if isStartTag(line, startTag) :
				found = true 
				#print("found start")
				continue	

		#we are seraching for a tag
		if isGoToTag(line, segmentTag) :
			print("found tag", segmentTag)
			found = true
			continue	
		
		if found :	
			if isGoTo(line) : 
				#print("found goto")
				found = false
				break
			
			if isStart(line) :
				found = false
				break
				
		# we have reached the end
		if isEnd(line):
			found = false
			break
			#print("found end")
				
		# if its an option 
		#we store store it and process it later
		
		# add story line into array
		if found : 
			storyBlocks.append(line.strip_edges())

	return storyBlocks
		

func getStorySegment(index: String, content: String):
	var block = content.split('\n')
	var found = false
	var newBlock = []
	for line in block:
		if line.find("scene :=") > -1 :
			if index == line.split(":=")[1].strip_edges():
				found = true
			else:
				found = false
			continue
		if found: 
			newBlock.append(line)	
		
	return newBlock
